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
      @threads = Model::Thread.all.reverse
      @title = "Thread List"
      erb :threads
    end

    # create thread.
    post '/threads' do
      # nil parameter
      unless params[:title] || params[:description]
        redirect '/threads'
      end

      # empty parameter
      if params[:title] == "" || params[:description] == ""
        redirect '/threads'
      end
      
      # title that already exists.
      if Model::Thread.where(:title => params[:title]).all.count >= 1
        redirect '/threads'
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

      # 作成したスレッドに移動する
      redirect "/threads/#{UUID}"
    end


    # show response
    get '/threads/:id' do |id|
      # not found thread
      @Thread = Model::Thread.where(:id => id).first
      redirect '/threads' unless @Thread

      @title = @Thread.title
      @res = Model::Response.where(:thread_id => @Thread.id).all
      erb :response
    end

    #post response
    post '/threads/:thread_id' do |id|
      # not found thread
      unless Model::Thread.where(:id => id).first
        redirect '/threads'
      end
      
      # validate parameters
      if !params[:message] || params[:message] == ""
        redirect 'threads/#{thread_id}'
      end


      Res_id =
        Model::Response.where(:thread_id => thread_id)
          .all
          .count + 1

      Model::Response.create do |res|
        res.id = Res_id
        res.thread_id = thread_id
        res.content = params[:message]
      end

      redirect '/thread/#{thread_id}'
    end
  end

end

