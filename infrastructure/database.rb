module InfraStructure

  DataBase = Sequel.connect( ENV['DB_PATH'] )

  DataBase.create_table? :thread do
    String :id, :primary_key => true
    String :title
    DateTime :created_at
  end

  DataBase.create_table? :response do
    Integer :id
    foreign_key :thread_id, :thread, :type => 'varchar(255)'
    String :content, :text => true
    DateTime :created_at
    primary_key [:id, :thread_id]
  end
end

