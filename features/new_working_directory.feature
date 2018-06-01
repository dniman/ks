Feature: new working directory

  Scenario: 
    Given Not Inside working directory
    When I run `ks new working_directory`
    Then the output should contain "create  "

    Given Inside working directory
    When I run `ks new working_directory`
    Then the output should contain "Can't create a new working directory within the directory of another, please change to a non-working directory first."
