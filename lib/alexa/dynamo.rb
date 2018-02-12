require 'aws-sdk-core'

module Alexa
  class Dynamo
    TABLE_NAME = 'Users'.freeze

    attr_reader :user_id, :dynamo

    def initialize(user_id)
      @user_id = user_id

      configure_aws
      @dynamo = Aws::DynamoDB::Client.new
    end

    def fetch_user_information
      dynamo.get_item(table_name: TABLE_NAME, key: { user_id: user_id }).item['info']
    rescue Aws::DynamoDB::Errors::ServiceError => error
      puts "Unable to retrive user. Error: #{error.message}"
    end

    private

    def configure_aws
      Aws.config.update(
        region: 'us-west-1',
        endpoint: 'http://localhost:8000' # TODO: use ENV var
      )
    end
  end
end
