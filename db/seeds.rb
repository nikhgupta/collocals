# default user
user = User.create email: "me@nikhgupta.com", name: "Nikhil Gupta",
  password: "password", password_confirmation: "password"
user.confirm!
