require_relative '../config' # think about moving to server.rb
require_relative './handlers'

module Alexa
  class Skill
    def self.register_intents
      Dir.glob('intents/*.rb').each { |intent_decleration| register(intent_decleration) }
    end

    def self.register(intent_decleration)
      Alexa::Handlers.class_eval File.open(File.expand_path(intent_decleration)).read
    end
  end
end

Alexa::Skill.register_intents
