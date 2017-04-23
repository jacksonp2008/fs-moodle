#
# Cookbook Name:: fs-moodle
# Recipe:: default
# basic instructions from here:  https://docs.moodle.org/26/en/Step-by-step_Installation_Guide_for_Ubuntu#Step_2:_Install_Apache.2FMySQL.2FPHP
#
# Copyright (c) 2017 - Steven Pollock
#
# Add the repo for PHP 5.6 which is required


# Ensure system apt-cache is up to date
include_recipe 'apt::default'

include_recipe 'ntp::default'

execute "add PHP repo" do
    command "sudo add-apt-repository -y ppa:ondrej/php; apt-get update"
  end

# Install packages
node['bootstrap_packages'].each do |pkg|
    package pkg
end

# This includes timezone, hostname and apt-update
include_recipe 'system::default'

# Load the correct php module for apache
execute "Load php5.6 for apache" do
    command "a2dismod php5; a2enmod php5.6"
  end

# Restart Apache
service "Apache2" do
    service_name "apache2"
   action [:restart]
end

# SSH Keyscan to avoid SSH fingerprint issues
execute "scan ssh fingerprints for git" do
    user node['moodle']['username']
    command "ssh-keyscan github.com >> ~vagrant/.ssh/known_hosts"
    not_if { `grep github.com ~vagrant/.ssh/known_hosts | wc -l`.chomp != "0" }
end

#Pull Moodle code from git repo and set the branch to the latest
execute "pull latest moodle code from git repo" do
    cwd "/opt"
    command "git clone git://git.moodle.org/moodle.git; cd moodle; git branch --track MOODLE_32_STABLE origin/MOODLE_32_STABLE; git checkout MOODLE_32_STABLE"
    not_if do ::File.directory?(File.join("/opt/moodle")) end
end

# Set up webroot with moodle code, do this every time to sync
execute "move moodle code to webroot" do
    cwd "/opt"
    command "cp -R /opt/moodle /var/www/html/ #{node['moodle']['webroot']}; chmod -R 0755 #{node['moodle']['webroot']}/moodle"
end

# Set up the moodledata directory, this has to be the same on every web server in a cluster (shared storage)
directory node['moodle']['data'] do
    owner  "www-data"
    mode   "0777"
    recursive true
    action :create
    not_if do ::File.directory?(node['moodle']['data']) end
end


#Provide mysql batch file to load any database commands
template 'mysql-moodle-batch' do
    path   "#{node['moodle']['data']}/mysql-moodle-batch"
    source 'mysql-moodle-batch.erb'
    owner  'root'
    group  'root'
    mode   '0644'
    variables(
      moodledatabase: node['moodle']['database'],
      moodleuser: node['moodle']['user'],
      moodleuserpw: node['moodle']['userpw']
    )
end

#Run the mysql batch script, only run if the database does not exist.  note: might want to add a root password
execute "run mysql batch commands" do
    command "mysql -u root  < #{node['moodle']['data']}/mysql-moodle-batch"
    not_if "mysql -u root -e 'use #{node['moodle']['database']}'"
end


### End of Moodle install, just a few other things to tidy up
# Bashrc override to fix PS1 on Ubuntu
template 'bash-bashrc' do
    path   '/etc/bash.bashrc'
    source 'bash.bashrc.erb'
    owner  'root'
    group  'root'
    mode   '0644'
end

template 'etc-skel-bashrc' do
    path   '/etc/skel/.bashrc'
    source 'bashrc.skel.erb'
    owner  'root'
    group  'root'
    mode   '0644'
end

# Post Installation instructions
# provide some text for now, push config.php longer term
template 'Final Instructions are in final-notes.txt' do
    path   "#{node['moodle']['data']}/final-notes.txt"
    source 'final-notes.erb'
    mode   '0644'
end


# Display the instructions
ruby_block "Final Instructions" do
  only_if { ::File.exists?("#{node['moodle']['data']}/final-notes.txt") }
  block do
    print "\n"
    print File.read("#{node['moodle']['data']}/final-notes.txt")
  end
end
