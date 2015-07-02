@omniauth @foursquare
Feature: Foursquare Omniauth Login
  In order to login promptly
  As a user
  I want to login using Foursquare

  Scenario: Registering with Foursquare
    Given I am not logged in
    And   I have not signed in with provider "foursquare" before
    Then  user with email "testuser@foursquare.com" should not exist
    When  I sign in with provider "foursquare"
    Then  I should be on the home page
    And   I should see "authenticated from Foursquare"
    And   user with email "testuser@foursquare.com" should be confirmed

  Scenario: Login with Foursquare
    Given I have signed in with provider "foursquare" before
    Then  user with email "testuser@foursquare.com" should exist
    Given I am not logged in
    When  I sign in with provider "foursquare"
    Then  I should be on the home page
    And   I should see "Signed in via Foursquare!"

  Scenario: Confirming with Foursquare
    Given I signup with email "testuser@foursquare.com" and password "password"
    Then  "testuser@foursquare.com" should receive an email
    And   user with email "testuser@foursquare.com" should not be confirmed
    Given I am not logged in
    When  I sign in with provider "foursquare"
    Then  I should see "Signed in via Foursquare! Confirmed email: testuser@foursquare.com!"
    And   user with email "testuser@foursquare.com" should be confirmed

  Scenario: Adding new Foursquare authentication when logged in
    Given I am logged in
    And   I have not signed in with provider "foursquare" before
    When  I click to add provider "foursquare" in my profile
    Then  I should see "Successfully linked"
    And   I should be on the edit profile page

  Scenario: Adding existing Foursquare authentication when logged in
    Given I am logged in
    And   I have signed in with provider "foursquare" before
    When  I click to add provider "foursquare" in my profile
    Then  I should see "already linked"
    And   I should be on the edit profile page

  Scenario: Identity associated with another user
    Given I have signed in with provider "foursquare" before
    Then  user with email "testuser@foursquare.com" should be confirmed
    Given I login with email "someotheruser@foursquare.com"
    When  I click to add provider "foursquare" in my profile
    Then  I should see "already associated with another"
    And   I should be on the edit profile page
