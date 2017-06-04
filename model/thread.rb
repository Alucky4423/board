# require_relative '../infrastructure/database'

module Model

  class Thread < Sequel::Model(:thread)
    def save
      self.created_at = Sequel::CURRENT_TIMESTAMP
      super()
    end

    def add_response(response)
      Model::Response.create do |res|
        res.thread_id = self.id
        res.content   = response
      end
    end

    def responses()
      if block_given?
        yield(Model::Response.where(:thread_id => self.id)).all
      else
        Model::Response.where(:thread_id => self.id).all
      end
    end
    
  end

end

