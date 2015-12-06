execute 'apt_update' do
  command 'apt-get update'
end 
# Base configuration recipe in Chef.
package "ruby-dev"
package "apache2"
package "libapache2-mod-passenger"
package "zlib1g-dev"
package "postgresql"
package "postgresql-contrib"
package "wget"
package "ntp"
package "sqlite3"
package "ack-grep"
package "libsqlite3-dev"
package "nodejs"
package "libpq-dev"
package "ri1.9.1"
package 'rbenv'
package 'curl'

cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

execute 'install_rails' do 
  command 'gem install --no-rdoc --no-ri rails'
end

execute 'install passenger' do
  command 'gem install passenger'
end

#execute 'install bootstrap' do
#  command 'gem install bootstrap-sass -v 3.3.5.1'
#end

execute 'postgres_user' do
  command "echo \"CREATE DATABASE mydb; CREATE USER vagrant WITH PASSWORD 'vagrant'; GRANT ALL PRIVILEGES ON DATABASE mydb TO vagrant;\" | sudo -u postgres psql"
end

#need to fix watchlist/customer table creation
execute 'create_db' do
  command "echo 'CREATE TABLE Movies (movieID serial NOT NULL, title varchar NOT NULL unique, genre varchar NOT NULL, year date NOT NULL, rating int NOT NULL, urlink varchar NOT NULL, synopsys varchar NOT NULL, PRIMARY KEY(movieID)); CREATE TABLE Users (uid serial not null, username varchar unique, password varchar, emailaddr varchar, primary key(uid)); CREATE TABLE WatchList (uid int, movieid int, foreign key(uid) references users(uid), foreign key(movieid) references movies(movieid));' | sudo -u vagrant psql mydb"
end

#execute 'insert_movie' do
#    command "echo \"INSERT INTO movie (movieid, title, author, genre, year, rating, urlink, synopsys) VALUES ('1', 'Star Wars: The Force Awakens', 'J.J. Abrams', 'Adventure', '12-18-2015','10','http://schmoesknow.com/wp-content/uploads/2015/07/Star_Wars.png','Lucasfilm and visionary director J.J. Abrams join forces to take you back again to a galaxy far, far away as Star Wars returns to the big screen with Star Wars: The Force Awakens.');  INSERT INTO movie (movieid, title, author, genre, year, rating, urlink,synopsys) VALUES ('2', 'Spectre','Sam Mendes', 'Action', '11-06-2015', '6', 'http://ia.media-imdb.com/images/M/MV5BMjM2Nzg4MzkwOF5BMl5BanBnXkFtZTgwNzA0OTE3NjE@._V1_SX214_AL_.jpg', 'A cryptic message from the past sends James Bond on a rogue mission to Mexico City and eventually Rome, where he meets Lucia Sciarra (Monica Bellucci), the beautiful and forbidden widow of an infamous criminal. Bond infiltrates a secret meeting and uncovers the existence of the sinister organisation known as SPECTRE. Meanwhile back in London, Max Denbigh (Andrew Scott), the new head of the Centre for National Security, questions Bonds actions and challenges the relevance of MI6, led by M (Ralph Fiennes). Bond covertly enlists Moneypenny (Naomie Harris) and Q (Ben Whishaw) to help him seek out Madeleine Swann (Lea Seydoux), the daughter of his old nemesis Mr White (Jesper Christensen), who may hold the clue to untangling the web of SPECTRE. As the daughter of an assassin, she understands Bond in a way most others cannot. As Bond ventures towards the heart of SPECTRE, he learns of a chilling connection between himself and the enemy he seeks, played by Christoph Waltz.'); \" | sudo -u vagrant psql mydb"
#end

execute 'bundle_inst' do
    cwd '/home/vagrant/project/webroot'
    command 'bundle install'
    user 'vagrant'
end

cookbook_file "000-default.conf" do
  path "/etc/apache2/sites-enabled/000-default.conf"
end

#execute 'migrate' do
#  cwd '/home/vagrant/project/webroot/bin'
#  command 'rake db:migrate RAILS_ENV=production'
#  user 'vagrant'
#end

execute 'assests' do
  cwd '/home/vagrant/project/webroot'
  command 'bundle exec rake assets:precompile RAILS_ENV=production'
  user 'vagrant'
end

execute 'apache2_restart' do
  command 'service apache2 restart'
end

#execute 'grab current' do
#  cwd '/home/vagrant/project/webroot'
#  command 'curl -o current.json http://api.themoviedb.org/3/movie/now_playing?api_key=10795773f625eb5f6b31994bf9953e09'
#end

#execute 'grab upcoming' do
#  cwd '/home/vagrant/project/webroot'
#  command 'curl -o upcoming.json http://api.themoviedb.org/3/movie/upcoming?api_key=10795773f625eb5f6b31994bf9953e09'
#end

execute 'grab genres' do
  cwd '/home/vagrant/project/webroot'
  command 'curl -o genre.json http://api.themoviedb.org/3/genre/movie/list?api_key=10795773f625eb5f6b31994bf9953e09'
end

execute 'reset db' do
  command 'echo "delete from watchlists; delete from movies; alter sequence movies_movieID_seq restart with 1"|sudo -u vagrant psql mydb'
end

execute 'fill db' do
  command 'ruby /home/vagrant/project/webroot/filldb.rb'
end
