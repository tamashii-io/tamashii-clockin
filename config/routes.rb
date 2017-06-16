# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Tamashii::Manager.server => '/tamashii' unless Rails.env.test?
end
