require './lib/alexa/request'
require './lib/alexa/response'

module Alexa
  class Handlers
    # rubocop:disable Style/ClassVars
    @@intents = {}
    # rubocop:enable Style/ClassVars

    def initialize(request)
      @request = request
    end

    def handle
      instance_exec request.user_id, &registered_intent(request.intent_name)
    end

    class << self
      def intent(intent_name, &block)
        @@intents[intent_name] = block
      end

      def handle(request)
        new(Alexa::Request.new(request)).handle
      end
    end

    attr_reader :request

    def registered_intent(intent_name)
      @@intents[intent_name]
    end

    def respond(response_details, session_attributes = {})
      Alexa::Response.build(response_details, session_attributes)
    end

    private :request, :registered_intent
  end
end
