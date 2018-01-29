require 'aws-sdk-core'

module Alexa
  class Dynamo
    TABLE_NAME = 'Users'.freeze

    def self.fetch_token(user_id)
      Aws.config.update(
        region: 'us-west-1',
        endpoint: 'http://localhost:8000'
      )

      dynamo_db = Aws::DynamoDB::Client.new
      begin
        user = dynamo_db.get_item(table_name: TABLE_NAME, key: { user_id: user_id }).item
      rescue Aws::DynamoDB::Errors::ServiceError => error
        puts "Unable to retrive user. Error: #{error.message}"
      end
      user['info']['access_key']
    end
  end
end
