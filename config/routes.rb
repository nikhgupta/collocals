require 'sidekiq/web'
Rails.application.routes.draw do

  mount Sidekiq::Web => '/monitor'
  root to: 'high_voltage/pages#show', id: 'home'

  resources :users, only: [:edit, :update]
  devise_for :users, skip: [:sessions, :registrations], controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
  }
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    match 'logout' => 'devise/sessions#destroy', as: :destroy_user_session,
      via: Devise.mappings[:user].sign_out_via
    get 'register' => 'users/registrations#new', as: :new_user_registration
    post 'register' => 'users/registrations#create', as: :user_registration
    get "profile/edit" => "users#edit", as: :edit_profile
  end
end
