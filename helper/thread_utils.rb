require 'securerandom'

module Helper

  module ThreadUtils
    # thread の一覧を返す
    def threads(id: nil)
      if id.nil?
        Model::Thread.all.reverse
      else
        Model::Thread.where(:id => id).first
      end
    end

    # 引数で渡されたタイトルのthreadがあれば,
    # そのインスタンスを返す。
    # 無ければ、nilを返す。
    def exists_title(title:)
      return ! Model::Thread.where(:title => title).empty?
    end


    # 新規スレッドを作成
    # titleが重複している場合は、nil を返す
    def create_thread(title:, desc:)
      return nil if exists_title(:title => title)

      uuid = SecureRandom.uuid.gsub(/-/, '')

      Model::Thread.create do |thread|
        thread.id     = uuid
        thread.title  = params[:title]
      end

      Model::Response.create do |response|
        response.id         = 1
        response.thread_id  = uuid
        response.content    = params[:description]
      end

      return Model::Thread.where(:id => uuid).first
    end

  end

end


