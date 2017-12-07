source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'aws-sdk', '~> 2.10'
gem 'attr_encrypted', '~> 3.0', github: 'attr-encrypted/attr_encrypted'
gem 'bootstrap', '4.0.0.alpha6'
gem 'delayed_job_active_record', '~> 4.1.2'
gem 'devise', '~> 4.3.0'
gem 'devise_invitable', '~> 1.7', '>= 1.7.2'
gem 'draper', '~> 3.0'
gem 'foreman'
gem 'kaminari', '~> 1.1'
gem 'local_time', '~> 2.0'
gem 'paranoia', '~> 2.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'slack-notifier', '~> 2.3.1'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 2.0'

group :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-ci'
  gem 'mocha', '~> 1.3'
  gem 'webmock', '~> 3.1'
  gem 'vcr', '~> 3.0', '>= 3.0.3'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.16'
  gem 'factory_girl_rails', '~> 4.9'
  gem 'faker', '~> 1.8'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'ruby-progressbar', '~> 1.9'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
