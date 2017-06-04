require 'securerandom'

module Helper

  module ThreadUtils
    # thread の一覧を返す
    def threads()
      return Model::Thread.all.reverse
    end

    # 引数で渡されたタイトルのthreadがあれば,
    # そのインスタンスを返す。
    # 無ければ、nilを返す。
    def existsTitle(title:)
      return Model::Thread.where(:title => title).first
    end

    def createThread(title:, desc:)
      uuid = SecureRandom.uuid.gsub(/-/, '')

      Model::Thread.create do |thread|
        thread.id = uuid
        thread.title = params[:title]
      end

      Model::Response.create do |response|
        response.id = 1
        response.thread_id = uuid
        response.content = params[:description]
      end

      return Model::Thread(:id => uuid).first
    end

  end

end


