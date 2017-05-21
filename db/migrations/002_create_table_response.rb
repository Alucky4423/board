Sequel.migration do

  up do
    self.create_table :response do
      foreign_key :thread_id,  :thread, :type => String
      Integer     :id,         :null => false
      String      :content,    :text => true, :null => false
      DateTime    :created_at, :null => false
      primary_key [:thread_id, :id]
    end
  end

  down do
    self.drop_table :response
  end

end

