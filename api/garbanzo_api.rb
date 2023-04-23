# Install the 'koala' gem by running 'gem install koala' in the terminal

require 'koala'

# Initialize a new instance of the Koala Facebook API with your app ID and app secret
facebook_api = Koala::Facebook::API.new(APP_ID, APP_SECRET)

# Define a method for sharing content to Facebook
def share_on_facebook(content)
  # Make a call to the Facebook API to post the content to the user's timeline
  facebook_api.put_wall_post(content)
  puts "Content shared on Facebook!"
rescue => e
  puts "Error sharing content on Facebook: #{e.message}"
end

# Define a method for sharing content to Twitter
def share_on_twitter(content)
  # Make a call to the Twitter API to post the content to the user's timeline
  # Replace the placeholders with your own API keys and access tokens
  consumer_key = 'your_consumer_key'
  consumer_secret = 'your_consumer_secret'
  access_token = 'your_access_token'
  access_token_secret = 'your_access_token_secret'

  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = consumer_key
    config.consumer_secret     = consumer_secret
    config.access_token        = access_token
    config.access_token_secret = access_token_secret
  end

  client.update(content)
  puts "Content shared on Twitter!"
rescue => e
  puts "Error sharing content on Twitter: #{e.message}"
end
