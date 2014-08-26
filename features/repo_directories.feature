Feature: Repository directory
  Scenario: uses current dir by default
    Given I'm in directory with repo
    When I run `repokeeper`
    Then the output should contain:
      """
      === MergeCommits ===
      071b66acda8ec70d37840d8a03029c963957dec7 by Anatoliy Plastinin. merge commit

      === ShortCommitMessage ===
      73f92f4a58173e651a5605d7c9384c6ea524df8a by Anatoliy Plastinin. Short commit message: !
      bae41e27ef0b254ac5b5a5657972f8570adc9699 by Anatoliy Plastinin. Short commit message: fix
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Short commit message: add file
      7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2 by Anatoliy Plastinin. Short commit message: add file

      === SimilarCommits ===
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Same commit message: 'add file'. See 7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2
      """

  Scenario: analyses relative dir
    Given I'm in directory without repo
    And repo is in "some/subdir" subdirectory
    When I run `repokeeper some/subdir`
    Then the output should contain:
      """
      === MergeCommits ===
      071b66acda8ec70d37840d8a03029c963957dec7 by Anatoliy Plastinin. merge commit

      === ShortCommitMessage ===
      73f92f4a58173e651a5605d7c9384c6ea524df8a by Anatoliy Plastinin. Short commit message: !
      bae41e27ef0b254ac5b5a5657972f8570adc9699 by Anatoliy Plastinin. Short commit message: fix
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Short commit message: add file
      7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2 by Anatoliy Plastinin. Short commit message: add file

      === SimilarCommits ===
      15a761d7232d383269e933083f984fcb30ff6fc5 by Anatoliy Plastinin. Same commit message: 'add file'. See 7776bbe8a59e4ad0013e0d2981f6ca81b1b1c8d2
      """
