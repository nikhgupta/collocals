@omniauth @linkedin
Feature: Linkedin Omniauth Login
  In order to login promptly
  As a user
  I want to login using Linkedin

  Scenario: Registering with Linkedin
    Given I am not logged in
    And   I have not signed in with provider "linkedin" before
    Then  user with email "testuser@linkedin.com" should not exist
    When  I sign in with provider "linkedin"
    Then  I should be on the home page
    And   I should see "authenticated from Linkedin"
    And   user with email "testuser@linkedin.com" should be confirmed

  Scenario: Login with Linkedin
    Given I have signed in with provider "linkedin" before
    Then  user with email "testuser@linkedin.com" should exist
    Given I am not logged in
    When  I sign in with provider "linkedin"
    Then  I should be on the home page
    And   I should see "Signed in via Linkedin!"

  Scenario: Confirming with Linkedin
    Given I signup with email "testuser@linkedin.com" and password "password"
    Then  "testuser@linkedin.com" should receive an email
    And   user with email "testuser@linkedin.com" should not be confirmed
    Given I am not logged in
    When  I sign in with provider "linkedin"
    Then  I should see "Signed in via Linkedin! Confirmed email: testuser@linkedin.com!"
    And   user with email "testuser@linkedin.com" should be confirmed

  Scenario: Adding new Linkedin authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "linkedin" before
    When  I click to add provider "linkedin" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Linkedin authentication when logged in
    Given I am logged in
    And   I have signed in with provider "linkedin" before
    When  I click to add provider "linkedin" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "linkedin" before
    Then  user with email "testuser@linkedin.com" should be confirmed
    Given I login with email "someotheruser@linkedin.com"
    When  I click to add provider "linkedin" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page


