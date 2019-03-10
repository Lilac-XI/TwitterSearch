class HomeController < ApplicationController
	$NG = "-RT -垢 -垢販売 -#白猫 -#垢販売 -#モンスト -#アカウント -#ツムツム -#ツムツム代行 -#販売 -#買取 -#売ります -#アカウント販売 -#FGO買取 -#FGO販売 -#デレステ -#石垢販売"
	def top
		
	end
	def search_premium
		if params[:from] != nil && params[:to] != nil && params[:word]
			if (params[:from].size != 12 || params[:to].size != 12) && params[:word]
				flash[:error] = "from,to １２桁"
			elsif params[:word]
				q = "#{$NG} #{params[:word]}"
				search = Search.premium(q,params[:from],params[:to])
				result = JSON.parse(search.body)
				result_pretty =JSON.pretty_generate(result)
				r = result["results"].to_a
				Tweet.PremiumtoDB(r,params[:word])
				@file_name = "(#{params[:word]})-#{params[:from]}-#{params[:to]}.json"
				save(result,params[:word],@file_name)
			end	
		end
	end

	def search_standerd
		if params[:word]
			dt = DateTime.now
			q = "#{$NG} #{params[:word]}"
			search = Search.standerd(q)
			result = JSON.parse(search.body)
			result_pretty =JSON.pretty_generate(@result)
			r = result["statuses"].to_a
			Tweet.StanderdtoDB(r,params[:word])
			@file_name = "#{params[:word]}-#{dt}.json"
			save(result,params[:word],@file_name)
			@x = Tweet.where(date: Date.today)
		end	
	end

	def read
	
	end

	def import
		file = params[:file].path
		file_name = params[:file].original_filename
  		json = ActiveSupport::JSON.decode(File.read(file))
  		word = file_name[(/(.*?)-/),1]
  		word[0] =''
  		word[-1] = ''
  		if json["results"] == nil && json["statuses"] != nil #standerd
  			result = json["statuses"]
  			Tweet.StanderdtoDB(result,word)
  		elsif json["results"] != nil && json["statuses"] == nil #premium
  			result = json["results"]
  			Tweet.PremiumtoDB(result,word)
  		else
  		end
  		render json: result
	end

	def download
		file_name = params[:file_name]
		send_file("json/#{file_name}")
		
	end

	def save(json,word,file_name)
		result =JSON.pretty_generate(json)
		output_path = Rails.root.join('json', file_name)
		File.open(output_path, 'w+b') do |fp|
			fp.write result
		end
		
	end

	def self.one2two(num)
		num = "#{num}"
		if num.size ==1
			num = "0#{num}"
		end
		return num
	end

	def self.Tokyo2UTC(date)
		d = ("#{date}").in_time_zone('Tokyo')
		td = d.in_time_zone('UTC')
		mon = one2two(td.mon)
		day = one2two(td.day)
		hour = one2two(td.hour)
		min = one2two(td.min)

		result = "#{td.year}#{mon}#{day}#{hour}#{min}"
		return result
	end

end
