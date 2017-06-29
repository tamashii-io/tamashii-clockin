# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'check_records#index'
  resources :users_admin, controller: 'users'
  resources :check_records, only: [:index]
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
  mount ActionCable.server => '/cable'
end
