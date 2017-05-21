# frozen_string_literal: true
source "https://rubygems.org"

ruby '2.3.1'

gem 'rack', '~> 1.6', '>= 1.6.5'
gem 'sinatra', '~> 1.4', '>= 1.4.8', :require => true
gem 'sinatra-contrib', '~> 1.4', '>= 1.4.7', :require => ['sinatra/reloader', 'sinatra/json']
gem 'sequel', '~> 4.46', :require => true

group :development, :test do
  gem 'sqlite3', '~> 1.3', '>= 1.3.13', :require => true
  gem 'rake', '~> 12.0'
end

group :production do
  gem 'pg'
end

