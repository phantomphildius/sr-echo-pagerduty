require 'faraday'
require './lib/alexa/dynamo'

module PagerDuty
  class Connection
    BASE_URL = 'https://api.pagerduty.com'.freeze
    AUTH_HEADER = 'Token token='.freeze
    ACCEPT_VERSION = 'application/vnd.pagerduty+json;version=2'.freeze

    attr_reader :user_id

    def initialize(user_id)
      @user_id = user_id
    end

    def configure
      Faraday.new(url: BASE_URL) do |connection|
        connection.headers['Authorization'] = "#{AUTH_HEADER}#{token}"
        connection.headers['Accept'] = ACCEPT_VERSION
        connection.adapter :net_http
      end
    end

    private

    def token
      Alexa::Dynamo.new(user_id).fetch_token
    end
  end
end
