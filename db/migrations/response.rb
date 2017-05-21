DB.create_table? :response do
  primary_key :id
  foreign_key :thread_id,  :null => false
  String      :content,    :null => false
  DateTime    :created_at, :null => false
end

