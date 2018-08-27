echo "##Installing some dependencies"
sudo apt-get install build-essential bison openssl libreadline7 libreadline-dev curl git-core zlib1g zlib1g-dev -dev libyaml-dev libxml2-dev autoconf libc6-dev ncurses-dev automake libtool

echo "##Installing NodeJS"
sudo apt-get install nodejs

echo "##Deleting the example folder"
sudo rm -r example/

echo "##Creating new folder"
rails new example

echo "##Getting into the example folder"
cd example/

echo "##Installing Rails-3 gem"
  sudo gem install rails -v "~> 3.0.0"

echo "##Adding rspec-rails at Gemfile"
echo "gem 'rspec-rails', :group => [:development, :test]" >> Gemfile
sed -i "s/^gem 'rails'.*/gem 'rails' \ngem 'pkg-config'\ngem 'prototype-rails'/" ./Gemfile

echo "##Installing bundle"
bundle install

echo "##setting config.eager_load at config/environments/*.rb"

sed -i "s/^Example::Application.configure do.*/Example::Application.configure do \n   config.eager_load=false/" ./config/environments/development.rb
sed -i "s/^Example::Application.configure do.*/Example::Application.configure do \n   config.eager_load=false/" ./config/environments/test.rb
sed -i "s/^Example\:\:Application\.configure do.*/Example\:\:Application\.configure do \n   config.eager_load=true/" ./config/environments/production.rb



echo "##Generating RSpec"
rails generate rspec:install

echo "##Generating an widget"
rails generate scaffold Widget name:string

echo "##Raking db migrate and test:prepare"
rake db:migrate && rake db:test:prepare

echo "##Raking spec"
rake spec
