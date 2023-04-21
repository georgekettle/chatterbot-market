require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Timeline
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
      html_tag
    }

    config.generators do |generate|
      generate.assets false # create assets when generating a scaffold
      # generate.force_plural false # allow pluralized model names
      generate.helper false # generate helpers
      # generate.integration_tool :test_unit # which tool generates integration tests (might be overwritten automatically if using rspec-rails)
      # generate.system_tests :test_unit # which tool generates system tests (might be overwritten automatically if using rspec-rails)
      # generate.orm false # which orm to use (false uses Active Record)
      # generate.resource_controller :controller # which generator generates a controller when using bin/rails generate resource
      generate.resource_route false # generate a resource route definition
      # generate.scaffold_controller :scaffold_controller # which generator generates a controller when using bin/rails generate scaffold
      generate.stylesheets false # generate stylesheets
      # generate.stylesheet_engine :css # configures the stylesheet engine (for e.g. sass) to be used when generating assets. Defaults to :css.
      # generate.scaffold_stylesheet true # creates scaffold.css when generating a scaffolded resource. Defaults to true.
      # generate.test_framework false # which test framework to use (false uses Minitest) (might be overwritten automatically if using rspec-rails)
      # generate.template_engine :erb # which template engine to use
    end
  end
end
