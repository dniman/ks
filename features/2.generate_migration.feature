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

    Scenario: Create migration
    Given I am inside working directory
    When I run `ks generate migration new_migration`
    Then the output should match:
    """
    create  db/migrations/\d{14}_new_migration.sql
    """

    Scenario: Create migration and proc files
    Given I am inside working directory
    When I run `ks generate migration create_procedure_new_procedure`
    Then the output should match:
    """
    create  db/migrations/\d{14}_create_procedure_new_procedure.sql
    """
    And the output should match:
    """
    create  src/proc/new_procedure.prc
    """

    Scenario: Create proc file in custom directory
    Given I am inside working directory
    When I run `ks generate migration create_procedure_new_procedure -d some_directory`
    Then the output should match:
    """
    create  src/proc/some_directory/new_procedure.prc
    """
    