# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
execute 'key_update' do
  command 'apt-key update'
end 

execute 'apt_update' do
  command 'apt-get update'
end 

# Base configuration recipe in Chef.
package "apache2"
package "libapache2-mod-passenger"

package "wget"
package "ntp"
package "postgresql"
package "ack-grep"

cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

# rails setup
package 'ruby1.9.1-dev'
package 'ruby1.9.1'
package 'ri1.9.1'
package 'rbenv'
package 'rdoc1.9.1'
package 'irb1.9'
package 'libreadline-ruby1.9.1'
package 'libruby1.9.1'
package 'libxslt-dev'
package 'libxml2-dev'
package 'zlib1g-dev'
package 'libsqlite3-dev'
package 'nodejs'
package 'make'
package 'libpq-dev'


execute 'install rails gem' do
    command 'gem install rails --no-ri --no-rdoc'
end

execute 'install passenger' do
  command 'gem install passenger'
end


execute 'bundle_inst' do
    cwd '/home/vagrant/project/blog'
    command 'bundle install'
    user 'vagrant'
end

#execute 'run server' do
#    cwd '/home/vagrant/project/blog'
#    command './bin/rails server -d -b 0.0.0.0'
#    user 'vagrant'
#end

execute 'migrate' do
  cwd '/home/vagrant/project/blog/bin'
  command 'rake db:migrate -V'
  user 'vagrant'
end

cookbook_file "000-default.conf" do
  path "/etc/apache2/sites-enabled/000-default.conf"
end

execute 'apache2_restart' do
  command 'service apache2 restart'
end

execute 'postgres_user' do
  command 'echo "CREATE DATABASE mydb; CREATE USER vagrant; GRANT ALL PRIVILEGES ON DATABASE mydb TO vagrant;" | sudo -u postgres psql'
end
