require 'sinatra'
require './lib/alexa/skill'

post '/' do
  Alexa::Handlers.handle(request)
end
