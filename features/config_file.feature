Feature: Configuration file
  Scenario: App uses settings from configuration file
    Given I'm in directory with repo "many_branches_repo"
    And a file named ".repokeeper.yml" with:
      """
      local_branches_count:
        max_local_branches: 100

      remote_branches_count:
        max_remote_branches: 100
      """
    When I run `repokeeper -c .repokeeper.yml`
    Then the output should contain:
      """
      === LocalBranchesCount ===
      No issues were found

      === RemoteBranchesCount ===
      No issues were found
      """

  Scenario: App doesnt run analyzers with enabled: false key
    Given I'm in directory with repo "many_branches_repo"
    And a file named ".repokeeper.yml" with:
      """
      local_branches_count:
        enabled: false

      remote_branches_count:
        enabled: false
      """
    When I run `repokeeper -c .repokeeper.yml`
    Then the output should not contain:
      """
      === LocalBranchesCount ===
      """
    And the output should not contain:
      """
      === RemoteBranchesCount ===
      """

  Scenario: Works correctly with empty analyzer keys
    Given I'm in directory with repo "many_branches_repo"

    And a file named ".repokeeper.yml" with:
      """
      local_branches_count:

      remote_branches_count:

      """

    When I run `repokeeper -c .repokeeper.yml`
    Then the output should contain:
      """
      === LocalBranchesCount ===
      """
    And the output should contain:
      """
      === RemoteBranchesCount ===
      """

  Scenario: Overrides default (including empty) settings
    Given I'm in directory with repo
    And a file named ".repokeeper.yml" with:
      """
      local_branches_count:
        enabled: false

      remote_branches_count:
        enabled: false

      merge_commits:
        enabled: false

      short_commit_message:
        message_min_length: 10

      similar_commits:
        min_edit_distance: 4
      """
    When I run `repokeeper -c .repokeeper.yml`
    Then the output should not contain:
      """
      === LocalBranchesCount ===
      """
    And the output should not contain:
      """
      === RemoteBranchesCount ===
      """
    And the output should not contain:
      """
      === MergeCommits ===
      """
    And the exit status should be 0
