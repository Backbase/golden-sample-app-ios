Feature: Account Details Display

  As a user of the golden sample app,
  I want to be able to view the details of an account
  So that I can access all relavant financial data for that specific account. 

  Background: User login 
    Given I have successfully lauched the golden sample app
    And the environment is setup up
    And I am presented with the login screen 
    And I provide valid credentials (e.g a correct username e.g `sdbxaz-dev-emily` and password e.g `wRmGXkuaD5vYVHmz`, or valid passcode). Other test users can be found here https://backbase.io/documentation/api-sandbox/retail-banking-usa/retail-user-credentials
    When I complete the login process
    Then I should be securely logged into the golden sample app and presented with the account list screen.
    
  Scenario: Display Account Details Upon Selection
    Given I am on the Account List screen, which displays a comprehensive list of Accounts
    When I carefully select and tap on the very first account listed in the visible accounts list
    Then the application should navigate me directly to the Account Details screen for the selected account
    And I should see all the specific details pertaining to that particular account, such as it's balance, account name and any other info, clearly displayed on the screen
  