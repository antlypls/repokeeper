module Repokeeper::Analyzers
  class LocalBranchesCount < Analyzer
    include BranchesAnalyzer
    include BranchesCount

    def max_branches
      @config['max_local_branches']
    end

    private

    def get_branches(repo)
      repo.local_branches
    end

    def message
      'too many local branches'
    end
  end
end
