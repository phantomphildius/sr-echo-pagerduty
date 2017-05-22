require 'sinatra'
require 'pry'
require 'faraday'
require 'json'
require './config.rb'

post '/' do
  return Alexa::Response.build(PagerDuty::Incident.last_alert_title)
  return Alexa::Response.build(PagerDuty::OnCall.on_call_names)
end
