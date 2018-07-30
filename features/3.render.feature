Feature: Render

  In order to move the code from migration files into src files
  As a user
  I want to run command ks render

    Scenario: Print error message
      Given I am outside of working directory
      When I run `ks render`
      Then the output should contain:
      """
      Can't run command outside of working directory
      """

    Scenario: Copy content
      Given I am inside working_directory
      When I run `ks render`
      Then the output should match:
      """
      create  src\/*
      """