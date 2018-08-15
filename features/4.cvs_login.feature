Feature: cvs login
  
  In order to use cvs 
  As a user
  I want to run command ks cvs login

    Scenario: Print error message
      When I run `ks cvs login`
      Then the output should contain:
      """
      CVS password:
      """