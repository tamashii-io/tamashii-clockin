# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.0'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'

gem 'sassc-rails'
gem 'jquery-rails'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'slim-rails'
gem 'font-awesome-rails'
gem 'simple-line-icons-rails', '~> 0.1.2'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'simple_form'
gem 'gretel'
gem 'groupdate'
gem 'kaminari'

gem 'devise'
gem 'pundit'

gem 'settingslogic'
gem 'tamashii', '~> 0.3.6'
gem 'tamashii-common', '~> 0.1.6'
gem 'tamashii-manager', '~> 0.2.4'
gem 'active_model_serializers'

gem 'rails-i18n'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'

  gem 'dotenv-rails'
  gem 'rubocop', '0.49.1', require: false
  gem 'scss_lint', require: false
  gem 'timecop'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Rails Console Helper
  gem 'pry'
  gem 'pry-rails'
  gem 'hirb'
  gem 'awesome_print'

  gem 'letter_opener'

  gem 'capistrano', '~> 3.6'
  gem 'capistrano-rails', '~> 1.2'
  gem 'capistrano-passenger'
  gem 'capistrano-upload-config'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
