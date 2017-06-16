# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  resources :check_records, only: [:index]
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
end
