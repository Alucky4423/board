# encoding: utf-8

# require Gemfile
require 'bundler'
Bundler.require

Dir.glob("./{infrastructure,model,helper}/**/*.rb").each do |file|
  require_relative file
end

module Board

  class Application < Sinatra::Application

    helpers do
      include Rack::Utils
      include Helper::ThreadUtils

      def invalidate(param)
        return param.nil? || param.empty?
      end
    end

    get '/' do
      redirect("/threads")
      # erb :index
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
        redirect '/threads' if invalidate(params[key])
      end

      if Thread = create_thread(:title => params[:title], :desc => params[:description])
        redirect "/threads/#{Thread.id}"
      else
        redirect "/threads"
      end
    end


    # show response
    get '/threads/:id' do |id|
      if Thread = threads(:id => id)
        @res       = Thread.responses
        @title     = Thread.title
        @thread_id = Thread.id
        erb :response
      else
        redirect '/threads'
      end
    end


    #add response
    post '/threads/:thread_id' do |id|
      if Thread = threads(:id => id)

        if invalidate(params[:response])
          redirect "threads/#{Thread.id}"
        end

        Thread.add_response(params[:response])

        redirect "/threads/#{Thread.id}"
      else
        redirect '/threads'
      end

    end
  end

end
