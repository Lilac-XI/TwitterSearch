class Twitter
  include ActiveModel::Model

  def self.access_token
    consumer = OAuth::Consumer.new(ENV["TWITTER_API_KEY"], ENV["TWITTER_API_SECRET_KEY"], { :site => "https://api.twitter.com", :scheme => :header })
    token_hash = { :oauth_token => ENV["TWITTER_ACCESS_TOKEN"], :oauth_token_secret => ENV["TWITTER_ACCESS_TOKEN_SECRET"] }

    return access_token = OAuth::AccessToken.from_hash(consumer,token_hash)
  end

  def self.client

  	return self.access_token
  	
  end
end
