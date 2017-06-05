require 'aws-sdk'
require './lib/alexa/request'

class Alexa
  class Dynamo
    TABLE_NAME = "Users"

    def initialize()
      Aws.config.update({
        region: "us-west-1",
        endpoint: "http://localhost:8000"
      })

      Aws::DynamoDB::Client.new
    end

    def get_access_key!
      user = nil
      dynamo_db = new()
      begin
        user = dynamo_db.get_item({table_name: TABLE_NAME, key: {user_id: REPLACE_ME}})
      rescue Aws::DynamoDB::Errors::ServiceError  => error
        puts "Unable to retrive user. Error: #{error.message}"
      end
      user[:item][:info][:access_key]
    end
  end
end
