source 'https://rubygems.org'

if ENV['RUBY_VERSION']
  ruby(ENV['RUBY_VERSION'])
end

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'active_model_serializers', '~> 0.10.0'
gem 'attr_encrypted', '~> 3.1', github: 'attr-encrypted/attr_encrypted'
gem 'aws-sdk', '~> 2.10'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'daredevil', '~> 0.0.2'
gem 'delayed_job_active_record', '~> 4.1.3'
gem 'devise', '~> 4.5.0'
gem 'devise_invitable', '~> 1.7'
gem 'draper', '~> 3.0'
gem 'foreman'
gem 'hootstrap', '~> 0.7.0'
gem 'kaminari', '~> 1.1'
gem 'local_time', '~> 2.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.12'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'rails', '~> 5.2.0'
gem 'sass-rails', '~> 5.0'
gem 'slack-notifier', '~> 2.3.2'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 3.5'

group :test do
  gem 'capybara', '~> 2.18'
  gem 'chromedriver-helper'
  gem 'minitest-ci'
  gem 'mocha', '~> 1.7'
  gem 'minitest-rails-capybara'
  gem 'selenium-webdriver'
  gem 'vcr', '~> 4.0'
  gem 'webmock', '~> 3.4'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'faker', '~> 1.9'
end

group :development do
  gem 'bullet', '~> 5.9.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'ruby-progressbar', '~> 1.10'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
