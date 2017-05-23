# encoding: utf-8

# require Gemfile
require 'bundler'
Bundler.require

require 'securerandom'

Dir.glob("./{infrastructure,model}/**/*.rb").each do |file|
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
      @threads = Model::Thread.all || []
      @threads.reverse!
      erb :threads
    end

    # create thread.
    post '/threads' do

      if params[:title] == "" || params[:description] == ""
        redirect '/threads'
        return
      end

      UUID = SecureRandom.uuid.gsub(/-/, '')

      Model::Thread.create do |thread|
        thread.id = UUID
        thread.title = params[:title]
      end

      
      Model::Response.create do |response|
        response.id = 1
        response.thread_id = UUID
        response.content = params[:description]
      end
      
      p Model::Response.all

      redirect '/threads'
    end

    # show response
    get '/threads/:id' do |id|
      @Thread = Model::Thread.where(:id => id).first
      redirect '/threads' unless Thread

      @title = @Thread.title
      @res = Model::Response.where(:thread_id => @Thread.id).all
      erb :response
    end

    #post response
    post '/threads/:id' do |id|
      # DB[:thread].where(:id => id)
    end
  end

end

