require 'twitter'
require 'facebook'

# Create a function to handle sharing content on social media
def share_content(content, platform)
  case platform
  when 'twitter'
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "your_consumer_key"
      config.consumer_secret     = "your_consumer_secret"
      config.access_token        = "your_access_token"
      config.access_token_secret = "your_access_token_secret"
    end

    client.update(content)

  when 'facebook'
    client = Facebook::Client.new do |config|
      config.app_id            = "your_app_id"
      config.app_secret        = "your_app_secret"
      config.access_token      = "your_access_token"
      config.access_token_secret = "your_access_token_secret"
    end

    client.share(content)
  end
end

# Example usage
share_content("Check out my awesome post on my app!", "twitter")
share_content("I just uploaded a new photo to my app!", "facebook")
