ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'simplecov'
require 'vcr'
require 'webmock/rspec'

SimpleCov.start "rails" do
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/helpers/application_helper.rb"
  add_filter "app/jobs/application_job.rb"
  add_filter "app/mailers/application_mailer.rb"
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

DatabaseCleaner.strategy = :truncation
RSpec.configure do |config|

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before(:all) do
    DatabaseCleaner.clean
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.include Capybara::DSL

  config.include FactoryBot::Syntax::Methods
  config.after(:each) do
    FactoryBot.reload
  end
end

Shoulda::Matchers.configure do |config|
    config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def stub_web_cal_request
  stub_request(:get, "http://www.webcal.fi/cal.php?id=50&format=json&start_year=current_year&end_year=next_year&tz=America%2FDenver").to_return(body: File.read("./spec/fixtures/webcal_request.json"))
end
