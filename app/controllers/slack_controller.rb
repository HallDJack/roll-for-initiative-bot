require 'sinatra'
require_relative '../services/initiative.rb'

post '/roll' do
  type = params['text']&.downcase

  if ['solo', 'team'].include?(type)
    response = {
      response_type: 'in_channel',
      text: Initiative.roll(type)
    }
  else
    response = {
      response_type: 'ephemeral',
      text: 'Sorry, that did not work. Please try again. Valid parameters are "solo" and "team".'
    }
  end

  content_type :json
  response.to_json
end
