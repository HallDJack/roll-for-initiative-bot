require 'sinatra'
require "sinatra/json"
require_relative '../services/initiative.rb'

post '/roll' do
  type = params['text']&.upcase

  if ['SOLO', 'TEAM'].include?(type)
    response = {
      response_type: 'in_channel',
      text: Initiative.roll(type)
    }
  else
    response = {
      response_type: 'ephemeral',
      text: 'Sorry, that did not work. Please try again. Valid parameters are "solo" and "group".'
    }
  end

  json response
end
