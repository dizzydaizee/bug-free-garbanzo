require 'sinatra'
require 'json'

# This is an example of a file storage endpoint
# that accepts file uploads and stores them on the server
post '/upload' do
  # Check if a file was uploaded
  if params[:file]
    # Get the file object
    file = params[:file]

    # Get the filename and extension
    filename = file[:filename]
    extension = File.extname(filename)

    # Generate a unique filename to avoid conflicts
    unique_filename = SecureRandom.hex(8)

    # Build the full filename with the unique name and extension
    full_filename = "#{unique_filename}#{extension}"

    # Save the file to the uploads directory
    File.open("uploads/#{full_filename}", 'wb') do |f|
      f.write(file[:tempfile].read)
    end

    # Return a JSON response indicating success
    { success: true, filename: full_filename }.to_json
  else
    # Return an error response if no file was uploaded
    { success: false, error: "No file uploaded" }.to_json
  end
end
