module Repokeeper::Analyzers
  # Analyzes merge commits
  # commits level analyzer
  class MergeCommits < Analyzer
    include CommitsAnalyzer

    def process_commit(commit)
      create_offense(commit, 'merge commit') if commit.parents.count > 1
    end
  end
end
