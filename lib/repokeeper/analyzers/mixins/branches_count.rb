module Repokeeper::Analyzers
  module BranchesCount
    def analyze(repo)
      branches = get_branches(repo)
      report(branches) if error?(branches)
    end

    private

    def error?(branches)
      branches.count > max_branches
    end

    def report(branches)
      create_offense(branches)
    end

    def create_offense(branches)
      Repokeeper::Offenses::BranchesOffense.new(branches, message, name)
    end
  end
end
