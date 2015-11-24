#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'pg'
upcoming = File.read('/home/vagrant/project/webroot/upcoming.json')
upcoming_hash = JSON.parse(upcoming)
current = File.read('/home/vagrant/project/webroot/current.json')
current_hash = JSON.parse(current)

conn = PG::connect(host: "localhost", user: "vagrant", password: "vagrant", dbname: "mydb")
conn.prepare('insert_movie', 'insert into movie(title, author, genre, year, rating, urlink, synopsys) values ($1, $2, $3, $4, $5, $6, $7)')
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

	conn.exec_prepared('insert_movie', [title, "", "", release, 0, poster, overview])
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
	

	conn.exec_prepared('insert_movie', [title, "", "", release, 0, poster, overview])
end
