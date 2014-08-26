module Repokeeper::Analyzers
  # Analyzes short commit messages
  # sign of undescriptive message
  # commits level analyzer
  class ShortCommitMessage < Analyzer
    include CommitsAnalyzer

    def message_min_length
      @config['message_min_length']
    end

    def process_commit(commit)
      create_offense_message(commit) if error?(commit)
    end

    private

    def error?(commit)
      commit.message.length < message_min_length
    end

    def create_offense_message(commit)
      create_offense(commit, "Short commit message: #{commit.message}")
    end
  end
end
