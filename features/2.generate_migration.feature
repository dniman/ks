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

    Scenario: Create migration and func files
      Given I am inside working directory
      When I run `ks generate migration create_function_new_function`
      Then the output should match:
      """
      create  db/migrations/\d{14}_create_function_new_function.sql
      """
      And the output should match:
      """
      create  src/func/new_function.udf
      """

    Scenario: Create func file in custom directory
      Given I am inside working directory
      When I run `ks generate migration create_function_new_function -d some_directory`
      Then the output should match:
      """
      create  src/func/some_directory/new_function.udf
      """    

    Scenario: Create migration and view files
      Given I am inside working directory
      When I run `ks generate migration create_view_new_view`
      Then the output should match:
      """
      create  db/migrations/\d{14}_create_view_new_view.sql
      """
      And the output should match:
      """
      create  src/view/new_view.viw
      """

    Scenario: Create view file in custom directory
      Given I am inside working directory
      When I run `ks generate migration create_view_new_view -d some_directory`
      Then the output should match:
      """
      create  src/view/some_directory/new_view.viw
      """ 

    Scenario: Create migration and trig files
      Given I am inside working directory
      When I run `ks generate migration create_trig_new_trig`
      Then the output should match:
      """
      create  db/migrations/\d{14}_create_trig_new_trig.sql
      """
      And the output should match:
      """
      create  src/trig/new_trig.trg
      """

    Scenario: Create trig file in custom directory
      Given I am inside working directory
      When I run `ks generate migration create_trig_new_trig -d some_directory`
      Then the output should match:
      """
      create  src/trig/some_directory/new_trig.trg
      """ 