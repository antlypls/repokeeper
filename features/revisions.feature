Feature: Revisions range
  Scenario: App analyses rev spec
    Given I'm in directory with repo
    When I run `repokeeper -r feature`
    Then the output should contain:
      """
      === MergeCommits ===
      No issues were found

      === ShortCommitMessage ===
      bae41e27ef0b254ac5b5a5657972f8570adc9699 by Anatoliy Plastinin. Short commit message: fix
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Short commit message: add file
      7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2 by Anatoliy Plastinin. Short commit message: add file

      === SimilarCommits ===
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Same commit message: 'add file'. See 7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2
      """

  Scenario: App analyses full rev spec
    Given I'm in directory with repo
    When I run `repokeeper --rev-range feature~3..feature`
    Then the output should contain:
      """
      === MergeCommits ===
      No issues were found

      === ShortCommitMessage ===
      bae41e27ef0b254ac5b5a5657972f8570adc9699 by Anatoliy Plastinin. Short commit message: fix

      === SimilarCommits ===
      No issues were found
      """
