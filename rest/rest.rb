require 'sinatra'

class BugFreeGarbanzo < Sinatra::Base
  # Define a GET route that returns a JSON object
  get '/api/data' do
    content_type :json
    { name: 'John Doe', age: 30 }.to_json
  end

  # Define a POST route that accepts JSON data and returns a JSON response
  post '/api/data' do
    request.body.rewind
    data = JSON.parse(request.body.read)
    # Your code to handle the data and return a response goes here
  end

  # Define a GET route that returns a greeting message
  get '/greeting' do
    'Hello, World!'
  end
end

# Run the server
run BugFreeGarbanzo.run!
