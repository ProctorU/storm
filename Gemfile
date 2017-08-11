source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'attr_encrypted', '~> 3.0', github: 'attr-encrypted/attr_encrypted'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'delayed_job_active_record', '~> 4.1.2'
gem 'devise', '~> 4.3.0'
gem 'devise_invitable', '~> 1.7', '>= 1.7.2'
gem 'foreman'
gem 'local_time', '~> 1.0', '>= 1.0.3'
gem 'paranoia', '~> 2.3', '>= 2.3.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.1'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker', '~> 2.0'

group :test do
  gem 'minitest-rails-capybara'
  gem 'minitest-ci'
  gem 'webmock', '~> 2.1'
  gem 'vcr', '~> 3.0', '>= 3.0.3'
end

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'factory_girl_rails', '~> 4.8'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
