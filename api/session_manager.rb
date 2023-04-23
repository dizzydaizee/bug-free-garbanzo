# file name: seventh_point.rb

require 'sinatra'
require 'json'

get '/users' do
  content_type :json
  users = [{ name: 'John', age: 30 }, { name: 'Jane', age: 25 }]
  users.to_json
end

post '/users' do
  content_type :json
  request.body.rewind
  data = JSON.parse request.body.read
  # Code to add user to database
  { message: "User #{data['name']} added successfully" }.to_json
end

put '/users/:id' do
  content_type :json
  request.body.rewind
  data = JSON.parse request.body.read
  # Code to update user with given id in database
  { message: "User with id #{params[:id]} updated successfully" }.to_json
end

delete '/users/:id' do
  content_type :json
  # Code to delete user with given id from database
  { message: "User with id #{params[:id]} deleted successfully" }.to_json
end
