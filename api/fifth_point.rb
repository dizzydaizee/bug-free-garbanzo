# Import necessary libraries
require 'sinatra'
require 'twilio-ruby'

# Set up Twilio client
account_sid = 'your_account_sid'
auth_token = 'your_auth_token'
client = Twilio::REST::Client.new(account_sid, auth_token)

# Set up Sinatra route to handle incoming SMS messages
post '/sms' do
  body = params[:Body].downcase
  sender = params[:From]

  if body.include?('hello')
    message = 'Hi there! How can I assist you?'
  elsif body.include?('garbanzo')
    message = 'Glad to hear you are interested in our project! Visit our website at www.garbanzo.com for more information.'
  else
    message = "I'm sorry, I didn't understand your request. Please try again."
  end

  # Send response message using Twilio
  client.messages.create(
    from: 'your_twilio_number',
    to: sender,
    body: message
  )

  # Return empty response to avoid showing default Sinatra error message
  status 204
end
