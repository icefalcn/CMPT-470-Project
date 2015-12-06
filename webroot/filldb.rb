#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'pg'
upcomingFile = File.read('/home/vagrant/project/webroot/upcoming.json')
upcoming_hash = JSON.parse(upcomingFile)
currentFile = File.read('/home/vagrant/project/webroot/current.json')
current_hash = JSON.parse(currentFile)
genreFile = File.read('/home/vagrant/project/webroot/genre.json')
genre_hash = JSON.parse(genreFile)
genre = Hash.new(0)

conn = PG::connect(host: "localhost", user: "vagrant", password: "vagrant", dbname: "mydb")
conn.prepare('insert_movie', 'insert into movies(title, genre, year, rating, urlink, synopsys, urlandscape) values ($1, $2, $3, $4, $5, $6, $7)')

genre_hash["genres"].each do |g|
	genre.store(g["id"], g["name"])
end

current_hash["results"].each do |movie|
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
	if movie["backdrop_path"].nil?
		posterlandscape = ""
	else
		posterlandscape = 'http://image.tmdb.org/t/p/w500' + movie["backdrop_path"]
	end

	conn.exec_prepared('insert_movie', [title, genres, release, 0, poster, overview, posterlandscape])
end

upcoming_hash["results"].each do |movie|
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
	if movie["backdrop_path"].nil?
		posterlandscape = ""
	else
		posterlandscape = 'http://image.tmdb.org/t/p/w500' + movie["backdrop_path"]
	end
	conn.exec_prepared('insert_movie', [title, genres, release, 0, poster, overview, posterlandscape])
end
