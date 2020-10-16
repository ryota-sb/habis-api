require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)

module RouteApi
  class Application < Rails::Application
    config.load_defaults 6.0
    config.api_only = true

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
        :headers => :any,
        :expose => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
        :methods => [:get, :post, :options, :delete, :put]
      end
    end

    config.generators do |g|
      g.test_framework false
    end
  end
end
