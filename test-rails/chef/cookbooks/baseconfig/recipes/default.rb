

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

execute 'postgres_user' do
  command 'echo "CREATE DATABASE mydb; CREATE USER vagrant; GRANT ALL PRIVILEGES ON DATABASE mydb TO vagrant;" | sudo -u postgres psql'
end

execute 'create_db' do
  command "echo 'CREATE TABLE contacts( fname varchar NOT NULL, lname varchar NOT NULL, email varchar NOT NULL, pnum varchar NOT NULL, notes text NOT NULL, created_at datetime NOT NULL, updated_at datetime NOT NULL);' | sudo -u vagrant psql mydb"
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
