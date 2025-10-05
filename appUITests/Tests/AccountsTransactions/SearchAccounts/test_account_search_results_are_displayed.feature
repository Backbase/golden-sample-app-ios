Feature: Account Search - Positive Results

  As a user of the golden sample app,
  I want to be able to search for specific accounts
  So that I can quickly find the account I am looking for among listed accounts

  Background: User login 
    Given I have successfully lauched the golden sample app
    And the environment is setup up
    And I am presented with the login screen 
    And I provide valid credentials (e.g a correct username e.g `sdbxaz-dev-emily` and password e.g `wRmGXkuaD5vYVHmz`, or valid passcode). Other test users can be found here https://backbase.io/documentation/api-sandbox/retail-banking-usa/retail-user-credentials
    When I complete the login process
    Then I should be securely logged into the golden sample app and presented with the account list screen.
    
  Scenario: Successful Display of Account Search Results
    Given I am on the Account List screen, which displays a comprehensive list of Accounts
    When I utilize the search functionality to perform a query for an account using the specific search term "Default Account Name".
    Then the search results area should clearly and accurately display an account matching the query
    And specifically, the displayed account should have the name "Default Account Name"
    And additionally, its corresponding account number should be "Default Account Number", confirming the Successful and precise retrieval of the intended account.

  Scenario: Display of Empty Search Results for Non-Existent Account
    Given I am on the Account List screen, which displays a comprehensive list of Accounts
    When I utilize the search functionality to perform a query for an account that I know does not exist, specifically "Dummy Inexistent Account"
    Then the application should indicate that no search results were found for my query
    And I should explicityly see a message or visual cue such as "No Results" prominently displayed in the search results are, signifying that no accounts matched my non-existent search term.
    
    
        
    
        
