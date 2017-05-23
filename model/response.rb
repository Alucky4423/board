# require_relative '../infrastructure/database'

module Model

  class Response < Sequel::Model(:response)
    def save
      self.created_at = Sequel::CURRENT_TIMESTAMP
      super()
    end
  end

end
