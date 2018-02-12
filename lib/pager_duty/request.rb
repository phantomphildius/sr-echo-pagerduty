module PagerDuty
  class Request
    def self.get(user_id, path, resource_id)
      connection(user_id).get(path, resource_id)
    end

    def self.where(user_id, path, options)
      connection(user_id).get(path, options)
    end

    def self.put(user_id, path, options)
      connection(user_id).put(path, options)
    end

    def self.connection(user_id)
      @connection ||= PagerDuty::Connection.new(user_id).configure
    end
  end
end
