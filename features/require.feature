Feature: Require external file
  Scenario: App requires provided file
    # Given I'm in directory with empty repo
    Given I'm in directory with repo
    And a file named "custom.rb" with:
      """
      puts '!!! custom file has been required'
      """
    When I run `repokeeper --require ./custom.rb`
    Then the output should contain:
      """
      !!! custom file has been required
      """
