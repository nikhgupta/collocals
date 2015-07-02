@omniauth @github
Feature: Github Omniauth Login
  In order to login promptly
  As a user
  I want to login using Github

  Scenario: Registering with Github
    Given I am not logged in
    And   I have not signed in with provider "github" before
    Then  user with email "testuser@github.com" should not exist
    When  I sign in with provider "github"
    Then  I should be on the home page
    And   I should see "authenticated from Github"
    And   user with email "testuser@github.com" should be confirmed

  Scenario: Login with Github
    Given I have signed in with provider "github" before
    Then  user with email "testuser@github.com" should exist
    Given I am not logged in
    When  I sign in with provider "github"
    Then  I should be on the home page
    And   I should see "Signed in via Github!"

  Scenario: Confirming with Github
    Given I signup with email "testuser@github.com" and password "password"
    Then  "testuser@github.com" should receive an email
    And   user with email "testuser@github.com" should not be confirmed
    Given I am not logged in
    When  I sign in with provider "github"
    Then  I should see "Signed in via Github! Confirmed email: testuser@github.com!"
    And   user with email "testuser@github.com" should be confirmed

  Scenario: Adding new Github authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "github" before
    When  I click to add provider "github" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Github authentication when logged in
    Given I am logged in
    And   I have signed in with provider "github" before
    When  I click to add provider "github" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "github" before
    Then  user with email "testuser@github.com" should be confirmed
    Given I login with email "someotheruser@github.com"
    When  I click to add provider "github" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page

