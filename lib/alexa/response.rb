require 'json'

VERSION = '1.0'.freeze

module Alexa
  class Response < Hash
    def initialize(response_text, session_attributes = {})
      self[:version] = VERSION
      self[:sessionAttributes] = session_attributes
      self[:response] = build_response_hash(response_text)
    end

    def self.build(response_text, session_attributes)
      new(response_text, session_attributes).to_json
    end

    private

    # rubocop:disable Metrics/MethodLength
    def build_response_hash(text)
      {
        outputSpeech: {
          type: 'PlainText',
          text: text
        }
      }
    end
    # rubocop:enable Metrics/MethodLength
  end
end
