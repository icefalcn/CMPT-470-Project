#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'open-uri'
require 'yt'

date = Time.now.strftime("%Y-%m-%d")
print date
url = "http://api.themoviedb.org/3/discover/movie?release_date.gte="+date+"&api_key=10795773f625eb5f6b31994bf9953e09"
File.write('future.json', open(url).read)

Yt.configure do |config|
  config.api_key = 'AIzaSyDK7Hzo96ktsJx1AMLsYBwNW417RNTIZCs'
end

videos = Yt::Collections::Videos.new

futureFile = File.read('future.json', :encoding => 'UTF-8')
future_hash = JSON.parse(futureFile)


future_hash["results"].each do |movie|
	title = movie["title"]
	print title + "\n"
#	print "https://www.youtube.com/watch?v="+ videos.where(q: "\""+title+" trailer\"", order: 'relevance', type: 'video', channelId: 'UCi8e0iOVk1fEOogdfu4YgfA').first.id + "\n"
end
