# require_relative '../infrastructure/database'

module Model

  class Response < Sequel::Model(:response)
    
    def self.generate_id(thread_id)
      Model::Response.where(:thread_id => thread_id).all.count + 1
    end

    def save
      self.id = Response.generate_id(self.thread_id)
      self.created_at = Sequel::CURRENT_TIMESTAMP
      super()
    end
  end

end
