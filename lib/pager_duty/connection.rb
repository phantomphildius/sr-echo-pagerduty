require 'pry'
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

    # rubocop:disable MethodLength
    def configure
      Faraday.new(url: BASE_URL) do |connection|
        connection.headers['Authorization'] = "#{AUTH_HEADER}#{user_token}"
        connection.headers['Accept'] = ACCEPT_VERSION
        connection.headers['From'] = 'afreeman@simplereach.com'
        connection.adapter :net_http
      end
    end
    # rubocop:enable MethodLength

    private

    def user_token
      user['access_key']
    end

    # TODO: store in Dynamo
    def user_email
      user['email']
    end

    def user
      @user ||= Alexa::Dynamo.new(user_id).fetch_user_information
    end
  end
end
