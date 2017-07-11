# frozen_string_literal: true

Rails.application.routes.draw do
  resources :check_records, only: [:index]
  devise_scope :user do
    get '/users/sign_up', to: 'check_records#index'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'check_records#index'
  resources :users_admin, controller: 'users'
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
  mount ActionCable.server => '/cable'
end
