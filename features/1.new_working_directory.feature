Feature: New working directory
  
  In order to create new "working directory"
  As a user
  I want to run command ks new "working directory"

    Scenario: Create new working directory
      When I run `ks new working_directory`
      Then the output should contain: 
      """
      create  working_directory
      create  working_directory/exe
      create  working_directory/exe/ks
      """
    
    Scenario: Print warning message
      Given I am already inside some working directory 
      When I run `ks new working_directory`
      Then the output should contain:
      """
      Can't generate a new working directory within the directory of another, please change to a non-working directory first.
      For details run: ks --help
      """ 