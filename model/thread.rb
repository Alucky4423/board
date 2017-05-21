module Model
  class Thread < Sequel::Model
    def save
      self.created_at = Sequel::CURRENT_TIMESTAMP
      super()
    end
  end
end

