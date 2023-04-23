class GarbanzoAPI < Sinatra::Base
  # Endpoint to retrieve user's personal data
  get '/users/:id/data' do
    # Ensure user is authenticated
    authenticate_user(request)

    # Retrieve user's data from the database
    user_data = UserData.find_by(user_id: params[:id])

    # Return the user's data as a JSON response
    json(user_data)
  end

  # Endpoint to update user's personal data
  put '/users/:id/data' do
    # Ensure user is authenticated
    authenticate_user(request)

    # Retrieve user's data from the database
    user_data = UserData.find_by(user_id: params[:id])

    # Update the user's data with the new information
    user_data.update(params[:data])

    # Return a success message
    json({ message: "User data updated successfully" })
  end
end
