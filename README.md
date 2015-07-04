Collocals
=========

> Of, from or in the same place as another.

## TODOs

### Users
- TODO: Allow users to login without confirming, and show a link to
  confirm on home page when they login.
- TODO: `Forgot password?` link should only appear when user logs in
  incorrectly multiple times.

## Notes

- To add a new `OmniAuth` identity:
  - Add corresp. gem to `Gemfile`, and run `bundle`.
  - Register for API keys.
  - Add API application keys as environment variables to `.env`.
  - Add API application keys to `devise` configuation.
  - Add new provider to `devise` block in `/app/models/user.rb`.
  - Make sure brand icon has colors in `/app/assets/identities.css.scss`.
  - Add method for new provider in `/app/controllers/users/omniauth_callback_controller.rb`
  - Implement extractor for this provider.
  - Restart server.
  - Do a test run to capture auth data.
  - Complete implementation of extractor.
  - Add tests for RSpec and Cucumber.
