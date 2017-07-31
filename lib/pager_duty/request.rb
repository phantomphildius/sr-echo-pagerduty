module PagerDuty
  class Request
    def self.get(user_id, path)
      connection(user_id).get(path)
    end

    def self.where(user_id, path, options)
      connection(user_id).get(path, options)
    end

    def self.connection(user_id)
      @connection ||= PagerDuty::Connection.configure(user_id)
    end
  end
end
