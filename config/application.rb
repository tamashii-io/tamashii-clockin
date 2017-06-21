# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

Dotenv::Railtie.load

module TamashiiClockin
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :"zh-TW"

    config.time_zone = 'Asia/Taipei'
    config.autoload_paths << Rails.root.join('app', 'tamashii')
  end
end
