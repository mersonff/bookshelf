# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth/v1/user'

  namespace :v1 do
    get 'home' => 'home#index'
    resources :authors
    resources :books
  end
end
