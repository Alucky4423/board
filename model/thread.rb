# require_relative '../infrastructure/database'

module Model

  class Thread < Sequel::Model(:thread)
    def save
      self.created_at = Sequel::CURRENT_TIMESTAMP
      super()
    end
    
  end

end

