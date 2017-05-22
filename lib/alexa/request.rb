require 'json'

module Alexa
  class Request < Hash
    def initialize(req)
      @request = JSON.parse(req.body.read)
    end

     def slot_value(slot_name)
       @request["request"]["intent"]["slots"][slot_name]["value"]
     end
  end
end
