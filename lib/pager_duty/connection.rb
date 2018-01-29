require 'faraday'
require './lib/alexa/dynamo'

module PagerDuty
  class Connection
    BASE_URL = 'https://api.pagerduty.com'.freeze
    AUTH_HEADER = 'Token token='.freeze
    ACCEPT_VERSION = 'application/vnd.pagerduty+json;version=2'.freeze
    attr_accessor :token, :base, :accept_version

    def initialize
      @@base_url = BASE_URL
      @@accept_version = ACCEPT_VERSION
    end

    def self.token(user_id)
      Alexa::Dynamo.fetch_token(user_id)
    end

    def self.configure(user_id)
      new
      Faraday.new(url: @@base_url) do |connection|
        connection.headers['Authorization'] = "#{AUTH_HEADER}#{token(user_id)}"
        connection.headers['Accept'] = @@accept_version
        connection.adapter :net_http
      end
    end
  end
end
