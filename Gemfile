source 'https://rubygems.org'

ruby '2.7.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'bcrypt', '~> 3.1.7'
gem 'faraday'
gem 'jwt'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rack-cors'
gem 'rails', '~> 6.0'
gem 'redis-rails'
gem 'rollbar'
gem 'sidekiq'
gem 'storext'

group :development, :test do
  gem 'dotenv-rails'
  gem 'faker'
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-clipboard'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'rspec-rails'
end

group :development do
  gem 'rubocop'
  gem 'rubocop-rails', require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'json_matchers'
  gem 'rspec'
  gem 'rspec-json_expectations'
  gem 'shoulda-matchers', '~> 4.0.0'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
