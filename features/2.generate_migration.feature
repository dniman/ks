Feature: Generate migration
  
  In order to generate new migration
  As a user
  I want to run command `ks generate migration [NAME]`

    Scenario: Print error message
    Given I am outside of working directory
    When I run `ks generate migration new_migration`
    Then the output should contain:
    """
    Can't run command outside of working directory
    """