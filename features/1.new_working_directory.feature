Feature: New working directory
  
  In order to create new "working directory"
  As a user
  I want to run command ks new "working directory"

    Scenario: Create new working directory
      When I run `ks new working_directory`
      Then the output should contain: 
      """
      create  
      """
      