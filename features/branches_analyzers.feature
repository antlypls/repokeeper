Feature: Branches analyzers
  Scenario: analyses local branches
    Given I'm in directory with repo "many_branches_repo"
    When I run `repokeeper`
    Then the output should contain:
      """
      === LocalBranchesCount ===
      too many local branches - five, four, master, one, six, three, two
      """

  Scenario: analyses remote branches
    Given I'm in directory with repo "many_branches_repo"
    When I run `repokeeper`
    Then the output should contain:
      """
      === RemoteBranchesCount ===
      too many remote branches - origin/five, origin/four, origin/master, origin/one, origin/three, origin/two
      """
