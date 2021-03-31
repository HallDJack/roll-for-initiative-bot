require 'sinatra'
require_relative '../services/initiative.rb'

post '/roll' do
  type = params['text']&.upcase

  if ['SOLO', 'TEAM'].include?(type)
    response = {
      response_type: 'in_channel',
      text: Initiative.roll("Initiative::#{type}".constantize)
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
