

execute 'apt_update' do
  command 'apt-get update'
end 

# Base configuration recipe in Chef.
package "apache2"
package "libapache2-mod-passenger"

package "ruby1.9.1-dev"
package "ruby-dev"
package "zlib1g-dev"
package "postgresql"
package "wget"
package "ntp"
package "sqlite3"
package "ack-grep"
package "libsqlite3-dev"
package "nodejs"
package "libpq-dev"
package "ri1.9.1"
package 'rbenv'

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

execute 'install bootstrap' do
  command 'gem install bootstrap-sass -v 3.3.5.1'
end

execute 'assests' do
  cwd '/home/vagrant/project/webroot'
  command 'bundle exec rake assets:precompile RAILS_ENV=production'
  user 'vagrant'
end

execute 'postgres_user' do
  command 'echo "CREATE DATABASE mydb; CREATE USER vagrant; GRANT ALL PRIVILEGES ON DATABASE mydb TO vagrant;" | sudo -u postgres psql'
end

execute 'create_db' do
  command "echo 'CREATE TABLE Movie (movieID serial NOT NULL, title varchar NOT NULL, author varchar NOT NULL, genre varchar NOT NULL, year date NOT NULL, rating int NOT NULL, urlink varchar NOT NULL, synopsys varchar NOT NULL, PRIMARY KEY(movieID));CREATE TABLE WatchList (wlID serial NOT NULL, movieID int NOT NULL, PRIMARY KEY(wlID), FOREIGN KEY (movieID) REFERENCES Movie (movieID)); CREATE TABLE Customers (username varchar NOT NULL, password varchar NOT NULL, name varchar NOT NULL, address varchar NOT NULL, emailAdd varchar NOT NULL, wlID int, PRIMARY KEY(username), FOREIGN KEY (wlID) REFERENCES WatchList (wlID));' | sudo -u vagrant psql mydb"
end

execute 'bundle_inst' do
    cwd '/home/vagrant/project/webroot'
    command 'bundle install'
    user 'vagrant'
end

execute 'migrate' do
  cwd '/home/vagrant/project/webroot/bin'
  command 'rake db:migrate RAILS_ENV=production'
  user 'vagrant'
end

cookbook_file "000-default.conf" do
  path "/etc/apache2/sites-enabled/000-default.conf"
end

execute 'apache2_restart' do
  command 'service apache2 restart'
end
