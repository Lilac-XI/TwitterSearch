class Tweet < ApplicationRecord
	has_many :images, dependent: :destroy

	def self.StanderdtoDB(result,word)
		result.each do |result|
				tw = Tweet.new
				tw.text = result["full_text"]
				tw.search_word = word
				t = result["created_at"].to_datetime.in_time_zone('Tokyo')
				tw.date = Date.new(t.year,t.month,t.day)
				hour = HomeController.one2two(t.hour)
				tw.time = "#{hour}#{t.min}#{t.sec}"
				tw.tweet_id = result["id"]
				tw.account_name = result["user"]["name"]
				tw.account_id = result["user"]["screen_name"]
				tw.account_icon_url = result["user"]["profile_image_url_https"]
				rt = result["retweet_count"]
				tw.rt = rt.to_i
				fav = result["favorite_count"]
				tw.fav = fav.to_i
				tw.url = "https://twitter.com/statuses/#{result['id']}"
				if result["extended_entities"] != nil
					x =  result["extended_entities"]
					x["media"].each do |media|
						url = tw.images.build(url: media["media_url_https"])
					end
				end
				if Tweet.find_by(tweet_id: tw.tweet_id) == nil
					tw.save
				else
					tw.destroy
				end
			end
			
	end

	def self.PremiumtoDB(result,word)
		result.each do |result|
				tw = Tweet.new
				tw.text = result["text"]
				tw.search_word = word
				t = result["created_at"].to_datetime.in_time_zone('Tokyo')
				tw.date = Date.new(t.year,t.month,t.day)
				hour = HomeController.one2two(t.hour)
				tw.time = "#{hour}#{t.min}#{t.sec}"
				tw.tweet_id = result["id"]
				tw.account_name = result["user"]["name"]
				tw.account_id = result["user"]["screen_name"]
				tw.account_icon_url = result["user"]["profile_image_url_https"]
				rt = result["retweet_count"]
				tw.rt = rt.to_i
				fav = result["favorite_count"]
				tw.fav = fav.to_i
				tw.url = "https://twitter.com/statuses/#{result['id']}"
				if result["extended_entities"] != nil
					x =  result["extended_entities"]
					x["media"].each do |media|
						url = tw.images.build(url: media["media_url_https"])
					end
				end

				if Tweet.find_by(tweet_id: tw.tweet_id) == nil
					tw.save
				else
					tw.destroy
				end
			end
	end
end
