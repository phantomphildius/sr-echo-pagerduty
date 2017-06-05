require "aws-sdk-core"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

params = {
  table_name: "Users",
  key_schema: [
    {
      attribute_name: "user_id",
      key_type: "HASH"
    }
  ],
  attribute_definitions: [
    {
      attribute_name: "user_id",
      attribute_type: "S"
    }
  ],
  provisioned_throughput: {
    read_capacity_units: 10,
    write_capacity_units: 10
  }
}

begin 
  result = dynamodb.create_table(params)
  puts "Created table. Status: #{result.table_description.table_status}"
rescue Aws::DynamoDB::Errors::ServiceError  => error
  puts "Unable to create table"
  puts "#{error.message}"
end
