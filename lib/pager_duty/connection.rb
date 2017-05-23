require 'faraday'

module PagerDuty
  class Connection
    BASE_URL = "https://api.pagerduty.com"
    AUTH_HEADER = "Token token="
    ACCEPT_VERSION = "application/vnd.pagerduty+json;version=2"
    attr_accessor :token, :base, :accept_version

    def initialize(args={})
      @@token = args[:token] || args["token"]
      @@base_url = args[:base_url] || args["base_url"] || BASE_URL
      @@accept_version = args[:accept_version] || args["accept_version"] || ACCEPT_VERSION
    end

    def self.configure
      new()
      Faraday.new(url: @@base_url) do |connection|
        connection.headers['Authorization'] = "#{AUTH_HEADER}#{@@token}"
        connection.headers['Accept'] = @@accept_version
        connection.adapter :net_http
      end
    end
  end
end
