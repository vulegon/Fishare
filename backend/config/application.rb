require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = true
    config.generators do |g|
      g.orm :active_record, primary_key_type: :uuid
    end
    # lib ディレクトリをオートロードパスに追加
    config.autoload_paths << Rails.root.join('lib')
    Faker::Config.locale = :ja
    config.i18n.default_locale = :ja
  end
end
