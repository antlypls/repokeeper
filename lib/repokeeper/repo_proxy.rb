require 'rugged'
require 'delegate'

module Repokeeper
  class RepoProxy
    # Walks specified range
    class BoundedWalker < SimpleDelegator
      def initialize(walker, rev_range)
        super(walker)
        @rev_range = rev_range
        configure_walker
      end

      private

      def configure_walker
        sorting(Rugged::SORT_TOPO)
        push(@rev_range.end_rev)
        hide(@rev_range.start_rev) if @rev_range.start_rev
      end
    end

    def initialize(repo_path)
      @repo = open_repo(repo_path)
    end

    def commits(rev_range = nil)
      rev_range ||= RevParser::RevRange.new
      rev_range = check_rev_range(rev_range)
      create_walker(rev_range).to_a
    end

    def local_branches
      @repo.branches.each_name(:local).sort
    end

    def remote_branches
      @repo.branches.each_name(:remote).sort
    end

    private

    def check_rev_range(rev_range)
      end_rev = rev_range.end_rev || @repo.head.name
      start_rev = rev_range.start_rev
      RevParser::RevRange.new(end_rev, start_rev)
    end

    def open_repo(repo_path)
      Rugged::Repository.discover(repo_path)
    end

    def create_walker(rev_range)
      walker = Rugged::Walker.new(@repo)
      BoundedWalker.new(walker, rev_range)
    end
  end
end
