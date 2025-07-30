Feature: Account List Display

  As a user of the golden sample app,
  I want to see my accounts clearly listed
  So that I can easily identify and access them.

  Background: User login 
    Given I have successfully lauched the golden sample app
    And the environment is setup up
    And I am presented with the login screen 
    And I provide valid credentials (e.g a correct username e.g `sdbxaz-dev-emily` and password e.g `wRmGXkuaD5vYVHmz`, or valid passcode). Other test users can be found here https://backbase.io/documentation/api-sandbox/retail-banking-usa/retail-user-credentials
    When I complete the login process
    Then I should be securely logged into the golden sample app and presented with the account list screen.
      
  Scenario: Display Account List
    Given I have successfully logged into the golden sample app and am on the main screen
    When I navigate to the Accounts List screen
    Then I should observe that the Accounts list screen is correctly displayed
    And it should present a clear and organized listing of all my associated accounts, ensuring they are readily visible and accessible for further interaction.
   