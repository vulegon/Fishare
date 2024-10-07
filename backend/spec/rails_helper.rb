# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :request
  ActiveJob::Base.queue_adapter = :test

  # テストスイートが始まる前に一度だけ実行
  config.before(:suite) do
    # マスターデータの作成
    FactoryBot.create(:support_contact_category, name: "other", description: "その他")
    FactoryBot.create(:support_contact_category, name: "manage_fishing_spot", description: "釣り場の作成・修正")
    FactoryBot.create(:support_contact_category, name: "feature_request", description: "機能のリクエスト")
    FactoryBot.create(:support_contact_category, name: "bug_report", description: "不具合の報告")
  end
end
