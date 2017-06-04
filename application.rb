# encoding: utf-8

# require Gemfile
require 'bundler'
Bundler.require

require 'securerandom'

Dir.glob("./{infrastructure,model,helper}/**/*.rb").each do |file|
  require_relative file
end

module Board

  class Application < Sinatra::Application

    helpers do
      include Rack::Utils
      include Helper::ThreadUtils
    end

    get '/' do
      erb :index
    end


    # show threads.
    get '/threads' do
      # @threads = Model::Thread.all.reverse
      @threads = threads
      @title = "Threads"
      erb :threads
    end

    # create thread.
    post '/threads' do
      # params validate.
      [:title, :description].each do |key|
        redirect '/threads' if params[key].nil? || params[key].empty?
      end

      if Thread = createThread(:title => params[:title], :desc => params[:description])
        redirect "/threads/#{Thread.id}"
      else
        redirect "/threads"
      end
    end


    # show response
    get '/threads/:id' do |id|
      # not found thread
      Thread = Model::Thread.where(:id => id).first
      redirect '/threads' unless Thread

      @res = Model::Response.where(:thread_id => Thread.id).all
      @title = Thread.title
      @thread_id = Thread.id
      erb :response
    end

    #post response
    post '/threads/:thread_id' do |thread_id|
      # not found thread
      unless Model::Thread.where(:id => thread_id).first
        redirect '/threads'
      end

      # redirect if params is nil or empty.
      if !params[:response] || params[:response] == ""
        redirect "threads/#{thread_id}"
      end


      Res_id =
        Model::Response
          .where(:thread_id => thread_id)
          .all
          .count + 1

      Model::Response.create do |res|
        res.id = Res_id
        res.thread_id = thread_id
        res.content = params[:response]
      end

      redirect "/threads/#{thread_id}"
    end
  end

end
