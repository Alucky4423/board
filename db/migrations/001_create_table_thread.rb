Sequel.migration do

  up do
    self.create_table :thread do
      String    :id,         :fixed => true, :size => 32
      String    :title,      :text => true, :null => false
      DateTime  :created_at, :null => false
      primary_key [:id]
    end
  end

  down do
    self.drop_table :thread
  end

end

