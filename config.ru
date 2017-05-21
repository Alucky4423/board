# coding: utf-8

# setting environment.
ROOT = File.dirname(__FILE__)

if ENV['RACK_ENV'] == "development"
  ENV['DB_PATH'] = "sqlite://db/database.db"
end

require_relative 'application'
run Board::Application

