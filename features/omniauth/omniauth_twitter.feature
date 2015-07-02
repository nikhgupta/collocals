@omniauth @twitter
Feature: Twitter Omniauth Login
  In order to login promptly
  As a user
  I want to login using Twitter

  Scenario: Registering with Twitter
    Given I am not logged in
    And   I have not signed in with provider "twitter" before
    When  I go to the login page
    And   I sign in with provider "twitter"
    Then  I should be on the new user registration page
    And   I should see field "Name" prefilled with "Test Twitter User"
    When  I signup with email "testuser2@twitter.com" and password "password2"
    Then  I should see "activate your account"
    And   "testuser2@twitter.com" should receive an email
    When  I sign in with provider "twitter"
    Then  I should see "confirm your email address before"
    When  I follow the confirmation link in the confirmation email
    Then  I should see "successfully confirmed"
    When  I sign in with provider "twitter"
    Then  I should be on the home page
    And   I should see "Signed in via Twitter!"

  Scenario: Login with Twitter
    Given I am not logged in
    And   I have signed in with provider "twitter" before
    When  I go to the login page
    And   I sign in with provider "twitter"
    Then  I should be on the home page
    And   I should see "Signed in via Twitter!"

  Scenario: Adding new Twitter authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "twitter" before
    When  I click to add provider "twitter" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Twitter authentication when logged in
    Given I am logged in
    And   I have signed in with provider "twitter" before
    When  I click to add provider "twitter" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "twitter" before
    Then  user with email "testuser@twitter.com" should be confirmed
    Given I login with email "someotheruser@twitter.com"
    When  I click to add provider "twitter" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page
