# Installer Structure
-
Pollock [jacksonp2008@gmail.com](mailto:jacksonp2008@gmail.com)  
April 2017

Edit 'update-cookbooks' to add any repo's to '/site-cookbooks'

Edit 'Berksfile' to add the cookbooks

Run the update-cookbooks script to load the repository and vendor the cookbooks.

### Example use:

Bring up vagrant and install chef.

Here is a sample Vagrantfile

```
cat Vagrantfile 
# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
# This is the base box we will use 
  config.vm.box = "ubuntu/trusty64"
# Setup the local network as you prefer
  config.vm.network "private_network", type: "dhcp"
# For some roles, more memory is required
  config.vm.provider "virtualbox" do |vb|
	vb.memory = "1024"
  end
end

$ vagrant up
$ vagrant ssh

```
### Install the latest ChefDK 
from the [Chef Download Site](https://downloads.chef.io/chef-dk/ubuntu/).

```
$ cd /vagrant
$ wget https://packages.chef.io/stable/ubuntu/12.04/chefdk_1.0.3-1_amd64.deb
$ sudo dpkg -i chefdk_1.0.3-1_amd64.deb
```

### Ready to Run
