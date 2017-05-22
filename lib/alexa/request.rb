require 'json'

module Alexa
  class Request < Hash
    def initialize(request)
      @request = JSON.parse(request.body.read)
    end

    def intent_name
      @request["request"]["intent"]["name"]
    end

     def slot_value(slot_name)
       @request["request"]["intent"]["slots"][slot_name]["value"]
     end
  end
end
