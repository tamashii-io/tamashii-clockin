# frozen_string_literal: true

set :deploy_to, '/home/deploy/clockin.5xruby.tw'
role :app, %w[deploy@do.5xruby.tw]
role :web, %w[deploy@do.5xruby.tw]
role :db, %w[deploy@do.5xruby.tw]
