#Below is the developer key which is used to establish a safe connection through OATH2
#A customer is created and then do a query on youtube, channel movieclipsTRAILERS with specific titles
#AIzaSyDK7Hzo96ktsJx1AMLsYBwNW417RNTIZCs

require 'youtube_it'
client = YouTubeIt::Client.new
client = YouTubeIt::Client.new(:dev_key => "AIzaSyDK7Hzo96ktsJx1AMLsYBwNW417RNTIZCs")
client = YouTubeIt::Client.new(:username => "youtube_username", :password =>  "youtube_passwd", :dev_key => "AIzaSyDK7Hzo96ktsJx1AMLsYBwNW417RNTIZCs")
client = YouTubeIt::OAuth2Client.new(client_access_token: "access_token", client_refresh_token: "refresh_token", client_id: "client_id", client_secret: "client_secret", dev_key: "dev_key", expires_at: "expiration time")
client.videos_by(:categories => [:user""], :tags => ['soccer', 'football'])
client.videos_by(:queyr => "Batman", :user => 'movieclipsTRAILERS')

