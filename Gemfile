source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.2'
# Connection different domain between back-end rails and front-end ionic
gem 'rack-cors', :require => 'rack/cors'
# A gem for delegate attributes and associations of belongs_to and has_one!
gem 'delegate_associations'
# Brings convention over configuration to your JSON generation.
gem 'active_model_serializers'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'coveralls', require: false

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
end

group :test do
  gem "codeclimate-test-reporter"
end

group :production do
  gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"
  gem 'pg'
end
