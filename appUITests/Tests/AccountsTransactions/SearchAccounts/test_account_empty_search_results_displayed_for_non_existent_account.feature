Feature: Account Search - Positive Results

  As a user of the golden sample app,
  I want to be clearly informed when my account search yields no results
  So that I understand why no accounts are displayed for my query

  Background: User login 
    Given I have successfully lauched the golden sample app
    And the environment is setup up
    And I am presented with the login screen 
    And I provide valid credentials (e.g a correct username and password, or valid passcode)
    When I complete the login process
    Then I should be securely logged into the golden sample app and presented with the account list screen.
    
  Scenario: Display of Empty Search Results for Non-Existent Account
    Given I am on the Account List screen, which displays a comprehensive list of Accounts
    When I utilize the search functionality to perform a query for an account that I know does not exist, specifically "Dummy Inexistent Account"
    Then the application should indicate that no search results were found for my query
    And I should explicityly see a message or visual cue such as "No Results" prominently displayed in the search results are, signifying that no accounts matched my non-existent search term.
    
        
    
        
