require 'json'

module Alexa
  class Response < Hash
    def initialize(response_text, session_attributes)
      self[:version] = '1.0'
      self[:sessionAttributes] = session_attributes
      self[:response] = {}
      self[:response][:outputSpeech] = {}
      self[:response][:outputSpeech][:type] = 'PlainText'
      self[:response][:outputSpeech][:text] = response_text
    end

    def self.build(response_text, session_attributes)
      new(response_text, session_attributes).to_json
    end
  end
end
