require_relative "boot"
require 'logger'
require "rails/all"
require "tzinfo/data" if Gem.loaded_specs.has_key?("tzinfo-data")

Bundler.require(*Rails.groups)


module SearchAnalytics
  class Application < Rails::Application
    config.api_only = true
    config.load_defaults 7.1
    config.autoload_lib(ignore: %w[assets tasks])
    config.assets.paths << Rails.root.join("app/assets/javascripts")
    config.active_record.belongs_to_required_by_default = false
    config.active_record.cache_versioning = false
  end
end
