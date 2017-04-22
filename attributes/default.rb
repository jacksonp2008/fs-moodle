# Default Packages and Users
default['bootstrap_packages'] = %w(git sysstat curl apache2 mysql-client mysql-server php5)

default['system']['timezone']       = "America/Los_Angeles"

# NTP
default['ntp']['servers'] = ['pool.ntp.org']
default['ntp']['apparmor_enabled'] = false
