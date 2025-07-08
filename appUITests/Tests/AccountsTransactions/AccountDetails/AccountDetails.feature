Feature: Account Overview & Details
  Background:
    Given the environment is setup up
    And the following test user is available:
        | Persona               | Full Name             | Username          |
        | Update                | Update                | Update            |
    And user navigates to the login screen
    And the login form is displayed with fields "Username" and "Password"
    When the user enters "username" and the "Password" fields or
    When the passcode form is displayed with the passcode field
    And the user enters the "passcode" field
    Then the user should be logged in successfully
    And the user is redirected to the Accounts screen
    
Scenario: Display Account Details
  When the user taps on the first account from the list
  Then the "Account Overview" screen is displayed
  
  When the user is on the Account details screen
  Then the account details for the selected account are displayed
  
        
    
        
