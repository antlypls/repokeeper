Feature: The executable works
  Scenario: shows help info
    When I run `repokeeper help`
    Then the output should contain:
      """
      repokeeper commands:
        repokeeper analyze [PATH]  # Analyze a git repository for common workflow flaws
        repokeeper help [COMMAND]  # Describe available commands or one specific command
      """

  Scenario: shows analyze help
    When I run `repokeeper help analyze`
    Then the output should contain:
      """
      Usage:
        repokeeper analyze [PATH]

      Options:
        -r, [--rev-range=REV_RANGE]  # Revisions to analyze by commits analyzers
        -c, [--config=CONFIG]        # Configuration file path
            [--require=REQUIRE]      # File to require
            [--formatter=FORMATTER]  # Formatter class name

      Analyze a git repository for common workflow flaws
      """

  Scenario: shows version
    When I run `repokeeper --version`
    Then the output should contain:
      """
      repokeeper 0.1.0
      """
