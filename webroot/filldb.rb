#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'pg'
require 'open-uri'

date = Time.now.strftime("%Y-%m-%d")
url = "http://api.themoviedb.org/3/discover/movie?release_date.gte="+date+"&api_key=10795773f625eb5f6b31994bf9953e09"
File.write('/home/vagrant/project/webroot/future.json', open(url).read)

File.write('/home/vagrant/project/webroot/current.json', open("http://api.themoviedb.org/3/movie/now_playing?api_key=10795773f625eb5f6b31994bf9953e09").read)

File.write('/home/vagrant/project/webroot/upcoming.json', open("http://api.themoviedb.org/3/movie/upcoming?api_key=10795773f625eb5f6b31994bf9953e09").read)


upcomingFile = File.read('/home/vagrant/project/webroot/upcoming.json')
upcoming_hash = JSON.parse(upcomingFile)
currentFile = File.read('/home/vagrant/project/webroot/current.json')
current_hash = JSON.parse(currentFile)
futureFile = File.read('/home/vagrant/project/webroot/future.json')
future_hash = JSON.parse(futureFile)
genreFile = File.read('/home/vagrant/project/webroot/genre.json')
genre_hash = JSON.parse(genreFile)
genre = Hash.new(0)

conn = PG::connect(host: "localhost", user: "vagrant", password: "vagrant", dbname: "mydb")
conn.prepare('insert_movie', 'insert into movies(title, genre, year, rating, urlink, synopsys) values ($1, $2, $3, $4, $5, $6)')

genre_hash["genres"].each do |g|
	genre.store(g["id"], g["name"])
end

current_hash["results"].each do |movie|
	begin
		title =movie["title"]
		if movie["release_date"].nil?
			release = ""
		else
			release = movie["release_date"]
		end
		if movie["poster_path"].nil?
			poster = ""
		else
			poster = 'http://image.tmdb.org/t/p/w500' + movie["poster_path"]
		end
		if movie["overview"].nil?
			overview = ""
		else
			overview = movie["overview"]
		end
		if movie["genre_ids"].nil?
			genres = ""
		else
			temp = Array.new
			ids = movie["genre_ids"]
			genres
			if ids.empty?
				genres = ""
			end
			ids.each do |t|
				if genres.nil?
					genres = genre[t]
				else
					genres = genres + ", " + genre[t]
				end
			end
		end

		conn.exec_prepared('insert_movie', [title, genres, release, 0, poster, overview])
	rescue PGError
	end
end

upcoming_hash["results"].each do |movie|
	begin
		title =movie["title"]
		if movie["release_date"].nil?
			release = ""
		else
			release = movie["release_date"]
		end
		if movie["poster_path"].nil?
			poster = ""
		else
			poster = 'http://image.tmdb.org/t/p/w500' + movie["poster_path"]
		end
		if movie["overview"].nil?
			overview = ""
		else
			overview = movie["overview"]
		end
		if movie["genre_ids"].nil?
			genres = ""
		else
			temp = Array.new
			ids = movie["genre_ids"]
			genres
			if ids.empty?
				genres = ""
			end
			ids.each do |t|
				if genres.nil?
					genres = genre[t]
				else
					genres = genres + ", " + genre[t]
				end
			end
		end

		conn.exec_prepared('insert_movie', [title, genres, release, 0, poster, overview])
	rescue PGError
	end
end

future_hash["results"].each do |movie|
	begin
		title =movie["title"]
		if movie["release_date"].nil?
			release = ""
		else
			release = movie["release_date"]
		end
		if movie["poster_path"].nil?
			poster = ""
		else
			poster = 'http://image.tmdb.org/t/p/w500' + movie["poster_path"]
		end
		if movie["overview"].nil?
			overview = ""
		else
			overview = movie["overview"]
		end
		if movie["genre_ids"].nil?
			genres = ""
		else
			temp = Array.new
			ids = movie["genre_ids"]
			genres
			if ids.empty?
				genres = ""
			end
			ids.each do |t|
				if genres.nil?
					genres = genre[t]
				else
					genres = genres + ", " + genre[t]
				end
			end
		end

		conn.exec_prepared('insert_movie', [title, genres, release, 0, poster, overview])
	rescue PGError
	end
end

conn.prepare('insert_watchlist', 'insert into watchlists(uid,movieid) values ($1, $2)')
for i in 1..10
conn.exec_prepared('insert_watchlist', [1,i ])
end
