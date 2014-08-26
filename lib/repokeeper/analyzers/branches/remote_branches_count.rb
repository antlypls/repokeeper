module Repokeeper::Analyzers
  class RemoteBranchesCount < Analyzer
    include BranchesAnalyzer
    include BranchesCount

    def max_branches
      @config['max_remote_branches']
    end

    private

    def get_branches(repo)
      repo.remote_branches
    end

    def message
      'too many remote branches'
    end
  end
end
