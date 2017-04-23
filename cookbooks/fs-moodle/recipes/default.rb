#
# Cookbook Name:: fs-moodle
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.
#
# Ensure system apt-cache is up to date
include_recipe 'apt::default'

include_recipe 'ntp::default'

# Install packages
node['bootstrap_packages'].each do |pkg|
    package pkg
end

# This includes timezone, hostname and apt-update
include_recipe 'system::default'
