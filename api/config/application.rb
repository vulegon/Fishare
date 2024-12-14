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
    config.active_job.queue_adapter = :sidekiq
    config.active_record.yaml_column_permitted_classes = [Symbol, Date, Time, ActiveSupport::TimeWithZone, ActiveSupport::TimeZone, BCrypt::Password, BigDecimal]
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
  end
end