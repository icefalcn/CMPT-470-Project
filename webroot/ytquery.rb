#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'open-uri'
require 'yt'

date = Time.now.strftime("%Y-%m-%d")
print date + "\n"
url = "http://api.themoviedb.org/3/discover/movie?release_date.gte="+date+"&api_key=10795773f625eb5f6b31994bf9953e09"
File.write('future.json', open(url).read)

yt = File.read("ytlinks.json")
ytlink = JSON.parse(yt)

Yt.configure do |config|
  config.api_key = 'AIzaSyDK7Hzo96ktsJx1AMLsYBwNW417RNTIZCs'
end

videos = Yt::Collections::Videos.new

futureFile = File.read('future.json', :encoding => 'UTF-8')
future_hash = JSON.parse(futureFile)

tmp = []
future_hash["results"].each do |movie|
	title = movie["title"]
	if ytlink["links"].nil?
		begin
			link = "https://www.youtube.com/watch?v="+ videos.where(q: "\""+title+" trailer\"", order: 'relevance', type: 'video', channelId: 'UCi8e0iOVk1fEOogdfu4YgfA').first.id
		rescue
			link = ""
		end
		tempHash = {:title => title, :link => link}
		tmp.push(tempHash)
	else
		bool = false
		tHash = {}
		ytlink["links"].each do |l|
			if l.has_value?(title)
				bool = true	
				tHash = l
			end
		end
		if bool == true
			tmp.push(tHash)
			print "got it\n"
		else
			print "failed\n"
			begin
				link = "https://www.youtube.com/watch?v="+ videos.where(q: "\""+title+" trailer\"", order: 'relevance', type: 'video', channelId: 'UCi8e0iOVk1fEOogdfu4YgfA').first.id
			rescue
				link = ""
			end
			tempHash = {:title => title, :link => link}
			tmp.push(tempHash)
		end
	end
end

target = File.open("ytlinks.json", 'w')
tempJson = {:links => tmp}
target.write(tempJson.to_json)
