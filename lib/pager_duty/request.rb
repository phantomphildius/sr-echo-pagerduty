module PagerDuty
  class Request
    def self.get(path)
      connection.get(path)
    end

    def self.where(path, options)
      connection.get(path, options)
    end

    def self.connection
      @connection ||= PagerDuty::Connection.configure()
    end
  end
end
