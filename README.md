Collocals
=========

This is a short description of your app. You MUST replace it, before
you even think about pushing this application to Github.

## TODO

- TODO: Update the README.

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
