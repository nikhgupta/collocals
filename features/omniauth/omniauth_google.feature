@omniauth @google
Feature: Google Omniauth Login
  In order to login promptly
  As a user
  I want to login using Google

  Scenario: Registering with Google
    Given I am not logged in
    And   I have not signed in with provider "google" before
    Then  user with email "testuser@google.com" should not exist
    When  I sign in with provider "google"
    Then  I should be on the home page
    And   I should see "authenticated from Google"
    And   user with email "testuser@google.com" should be confirmed

  Scenario: Login with Google
    Given I have signed in with provider "google" before
    Then  user with email "testuser@google.com" should exist
    Given I am not logged in
    When  I sign in with provider "google"
    Then  I should be on the home page
    And   I should see "Signed in via Google!"

  Scenario: Confirming with Google
    Given I signup with email "testuser@google.com" and password "password"
    Then  "testuser@google.com" should receive an email
    And   user with email "testuser@google.com" should not be confirmed
    Given I am not logged in
    When  I sign in with provider "google"
    Then  I should see "Signed in via Google! Confirmed email: testuser@google.com!"
    And   user with email "testuser@google.com" should be confirmed

  Scenario: Adding new Google authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "google" before
    When  I click to add provider "google" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Google authentication when logged in
    Given I am logged in
    And   I have signed in with provider "google" before
    When  I click to add provider "google" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "google" before
    Then  user with email "testuser@google.com" should be confirmed
    Given I login with email "someotheruser@google.com"
    When  I click to add provider "google" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page


