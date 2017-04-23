# Default Packages and Users
default['bootstrap_packages'] = %w(git sysstat curl apache2 mysql-client mysql-server php5 graphviz aspell php5-pspell php5-curl php5-gd php5-intl php5-mysql php5-xmlrpc php5-ldap php5.6 php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl php5.6-zip)

default['system']['timezone']       = "America/Los_Angeles"

# NTP
default['ntp']['servers'] = ['pool.ntp.org']
default['ntp']['apparmor_enabled'] = false

#moodle
default['moodle']['username'] = 'vagrant'     #for AWS is will be Ubuntu
default['moodle']['webroot'] = '/var/www/html/'
default['moodle']['data'] = '/var/moodledata'
default['moodle']['sqlrootpass'] = 'xxx'
default['moodle']['database'] = 'moodle'
default['moodle']['user'] = 'moodleuser'
default['moodle']['userpw'] = 'xxx'
