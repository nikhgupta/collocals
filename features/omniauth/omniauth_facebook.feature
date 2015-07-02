@omniauth @facebook
Feature: Facebook Omniauth Login
  In order to login promptly
  As a user
  I want to login using Facebook

  Scenario: Registering with Facebook
    Given I am not logged in
    And   I have not signed in with provider "facebook" before
    Then  user with email "testuser@facebook.com" should not exist
    When  I sign in with provider "facebook"
    Then  I should be on the home page
    And   I should see "authenticated from Facebook"
    And   user with email "testuser@facebook.com" should be confirmed

  Scenario: Login with Facebook
    Given I have signed in with provider "facebook" before
    Then  user with email "testuser@facebook.com" should exist
    Given I am not logged in
    When  I sign in with provider "facebook"
    Then  I should be on the home page
    And   I should see "Signed in via Facebook!"

  Scenario: Confirming with Facebook
    Given I signup with email "testuser@facebook.com" and password "password"
    Then  "testuser@facebook.com" should receive an email
    And   user with email "testuser@facebook.com" should not be confirmed
    Given I am not logged in
    When  I sign in with provider "facebook"
    Then  I should see "Signed in via Facebook! Confirmed email: testuser@facebook.com!"
    And   user with email "testuser@facebook.com" should be confirmed

  Scenario: Registering with Facebook without email permission
    Given I am not logged in
    And   I have not signed in with provider "facebook" before
    And   I do not want to expose my "email" via "facebook" provider
    When  I sign in with provider "facebook"
    Then  I should be on the new user registration page
    And   I should see field "Name" prefilled with "Test Facebook User"
    When  I signup with email "testuser2@facebook.com" and password "password2"
    Then  I should see "activate your account"
    And   "testuser2@facebook.com" should receive an email
    When  I sign in with provider "facebook"
    Then  I should see "confirm your email address before"
    When  I follow the confirmation link in the confirmation email
    Then  I should see "successfully confirmed"
    When  I sign in with provider "facebook"
    Then  I should be on the home page
    And   I should see "Signed in via Facebook!"

  Scenario: Adding new Facebook authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "facebook" before
    When  I click to add provider "facebook" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Facebook authentication when logged in
    Given I am logged in
    And   I have signed in with provider "facebook" before
    When  I click to add provider "facebook" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "facebook" before
    Then  user with email "testuser@facebook.com" should be confirmed
    Given I login with email "someotheruser@facebook.com"
    When  I click to add provider "facebook" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page
