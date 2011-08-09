maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Deploys and configures a variety of applications defined from databag 'apps'"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.99.12"
recipe           "application", "Loads application databags and selects recipes to use"
recipe           "application::passenger_apache2", "Sets up a deployed Rails application as a Passenger virtual host in Apache2"
recipe           "application::rails", "Deploys a Rails application specified in a data bag with the deploy_revision resource"

%w{ runit apache2 passenger_apache2 apache2 }.each do |cb|
  depends cb
end
