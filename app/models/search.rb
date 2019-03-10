class Search
	include ActiveModel::Model

	def self.standerd(word,mode = "mixed",num = 100)
		q = URI.encode(word)
		puts q
		response = Twitter.client.request(:get, "https://api.twitter.com/1.1/search/tweets.json?q=#{q}&result_type=#{mode}&count=#{num}&tweet_mode=extended&include_entities=true")
		
		return response
	end

	def self.premium(word,from,to,num = 100,type = "fullarchive")
		q = URI.encode "#{word}"
		from = HomeController.Tokyo2UTC(from)
		to = HomeController.Tokyo2UTC(to)
		response = Twitter.client.request(:get, "https://api.twitter.com/1.1/tweets/search/#{type}/result.json?query=#{q}&maxResults=#{num}&fromDate=#{from}&toDate=#{to}")

		return response
	end
end
