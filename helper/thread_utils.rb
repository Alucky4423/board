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
  end

end


