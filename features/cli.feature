Feature: The executable works
  Scenario: shows help info
    When I run `repokeeper -h`
    Then the output should contain:
      """
      Usage: repokeeper [options] [path]

      Repokeeper checks your repo for flaws

      v0.0.1

      Options:
          -h, --help                       Show command line help
              --version                    Show help/version info
          -r, --rev-range REV_RANGE        Revisions to analyze by commits analyzers
          -c, --config CONFIG_FILE         Configuration file
              --require REQUIRE_FILE       File to require
              --formatter FORMATTER_CLASS  Formatter class

      Arguments:

          path
              path to repo to analyze, current dir if not specified (optional)
      """

  Scenario: shows version
    When I run `repokeeper --version`
    Then the output should contain:
      """
      repokeeper version 0.0.1
      """
