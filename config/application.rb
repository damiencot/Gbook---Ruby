require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Gbook
  class Application < Rails::Application

    config.site = {
        name: 'Gbook'
    }

    # On précise à la génération d'un controller qu'on ne veut pas de certain fonctionaliste
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework false
      g.jbuilder false
    end

  end
end
