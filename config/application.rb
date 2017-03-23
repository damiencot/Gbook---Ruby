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

    # Je suis ouvert à une baisse de prix, je vous propose 170 au lieu de 190, qu'en pensez-vous ?
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework false
      g.jbuilder false
    end

    config.assets.paths << Rails.root.join('lib', 'assets', 'lib')

  end
end
