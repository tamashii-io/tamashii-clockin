# frozen_string_literal: true

Rails.application.routes.draw do
  devise_scope :user do
    get '/users/sign_up', to: 'check_records#index'
  end
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  root 'dashboard#index'

  resources :users_admin, controller: 'users' do
    member do
      patch 'recover'
    end
  end

  resources :check_records, only: [:index]
  resources :machines do
    scope module: :machines do
      resources :actions, only: [:create]
    end
  end
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
  mount ActionCable.server => '/cable'
end
