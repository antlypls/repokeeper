module Repokeeper::Analyzers
  # Checks for similar commits messages in commit ant its parents
  # commits level analyzer
  class SimilarCommits < Analyzer
    include CommitsAnalyzer

    def min_edit_distance
      @config['min_edit_distance']
    end

    def process_commit(commit)
      commit.parents.map do |parent|
        compare_commits(commit, parent)
      end.compact
    end

    private

    def compare_commits(newer, older)
      new_message = clean_commit_message(newer)
      old_message = clean_commit_message(older)

      distance = Repokeeper::Utils.edit_distance(new_message, old_message)
      error = error_message_by_distance(distance, new_message, old_message)
      create_offense_for_error(error, newer, older)
    end

    def error_message_by_distance(distance, new_message, old_message)
      if distance == 0
        "Same commit message: '#{new_message}'"
      elsif distance < min_edit_distance
        "Similar commit messages: '#{new_message}' and '#{old_message}'"
      end
    end

    def create_offense_for_error(error, newer, older)
      create_offense(newer, "#{error}. See #{older.oid}") if error
    end

    def clean_commit_message(commit)
      commit.message.gsub(/[\t\n]/, ' ').strip
    end
  end
end
