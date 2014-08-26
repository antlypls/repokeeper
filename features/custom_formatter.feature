Feature: Custom formatter
  Scenario: App uses class user in argumend as formatter
    # Given I'm in directory with empty repo
    Given I'm in directory with repo "simple_repo"
    And a file named "custom_formatter.rb" with:
      """
      class CustomFormatter
        def initialize(out_stream = $stdout)
          @out_stream = out_stream
        end

        def started
          @out_stream.puts 'started'
        end

        def commits_analyzer_results(analyzer_name, offenses)
          @out_stream.puts "commits_analyzer_results: #{analyzer_name}"
        end

        def branches_analyzer_results(analyzer_name, offenses)
          @out_stream.puts "branches_analyzer_results: #{analyzer_name}"
        end

        def finished
          @out_stream.puts 'finished'
        end
      end
      """
    When I run `repokeeper --require ./custom_formatter.rb --formatter CustomFormatter`
    Then the output should contain:
      """
      started
      commits_analyzer_results: MergeCommits
      commits_analyzer_results: ShortCommitMessage
      commits_analyzer_results: SimilarCommits
      branches_analyzer_results: LocalBranchesCount
      branches_analyzer_results: RemoteBranchesCount
      finished
      """
