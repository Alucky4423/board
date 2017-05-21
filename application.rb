# encoding: utf-8

# require Gemfile
require 'bundler'
Bundler.require

require 'securerandom'

Dir.glob("./{infrastructure,model}/**/*.rb").each do |file|
  puts file
  require_relative file
end

module Board

  DB = InfraStructure::DataBase

  class Application < Sinatra::Application

    get '/' do
      erb :index
    end

    #########################
    # Thread 
    #########################

    # show threads.
    get '/threads' do
      @threads = Model::Threads.all || []
      @threads.reverse!
      erb :threads
    end

    # create thread.
    post '/threads' do
      id          = SecureRandom.uuid.gsub(/-/, '')
      title       = params[:title]
      description = params[:description]
      timestamp   = Sequel::CURRENT_TIMESTAMP

      DB[:thread].insert(:id => id, :title => title, :created_at => timestamp)
      DB[:response].insert(:id => 1, :thread_id => id, :content => description, :created_at => timestamp)

      redirect '/threads'
    end

    get 'threads/:id' do |id|
      # DB[:thread].where(:id => id)
    end
  end

end

