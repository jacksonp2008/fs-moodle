# vagrant-prep-ruby
-
Pollock [jacksonp2008@gmail.com](mailto:jacksonp2008@gmail.com)  
February 2017

## Description

Exercise to build local Chef cookbook to run as 'chef -z' on vagrant running Ubuntu to prep a rails development environment.

Using [these instructions](http://railsapps.github.io/installrubyonrails-ubuntu.html) from RailsApp Project.

### Create the Repo on [GitHub](https://github.com/jacksonp2008/vagrant-prep-ruby)

and clone locally

```
git clone https://github.com/jacksonp2008/vagrant-prep-ruby.git
Cloning into 'vagrant-prep-ruby'...
warning: You appear to have cloned an empty repository.
```
### Create the base cookbook

```
chef generate cookbook .
Generating cookbook vagrant-prep-ruby
- Ensuring correct cookbook file content
- Ensuring delivery configuration
- Ensuring correct delivery build cookbook content

Your cookbook is ready. Type `cd .` to enter it.

There are several commands you can run to get started locally developing and testing your cookbook.
Type `delivery local --help` to see a full list.

Why not start by writing a test? Tests for the default recipe are stored at:

test/recipes/default_test.rb

If you'd prefer to dive right in, the default recipe can be found at:

recipes/default.rb

```

### Build the Recipe

Once the cookbook is complete, setup an an [installer structure](https://github.com/jacksonp2008/vagrant-builds) to work within, you can add other cookbooks as needed once in place.

