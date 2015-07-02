FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name "User 1"
    email
    password "password"
    password_confirmation "password"

    trait :confirmed do
      initialize_with do
        user = User.new
        user.skip_confirmation!
        user
      end
    end

    trait :full_info do
      gender "male"
      image  "http://url.to/image.jpg"
      language "hi"
      timezone_offset 19800
    end

    factory :confirmed_user,      traits: [:confirmed]
    factory :user_with_full_info, traits: [:full_info]
  end
end
