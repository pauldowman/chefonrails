#
# Cookbook Name:: application
# Recipe:: passenger_apache2
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

app = node.run_state[:current_app] 

include_recipe "apache2"
include_recipe "apache2::mod_ssl"
include_recipe "apache2::mod_rewrite"
include_recipe "passenger_apache2::mod_rails"

allowed_hostnames = (app['hostnames'] && app['hostnames'][node.chef_environment]) || []
other_hostnames = (app['hostname_aliases'] && app['hostname_aliases'][node.chef_environment]) || []
other_hostnames << node.fqdn

if node.has_key?("cloud")
  other_hostnames << node['cloud']['public_hostname']
end
  
web_app app['id'] do
  docroot "#{app['deploy_to']}/current/public"
  template "passenger_web_app.conf.erb"
  cookbook "passenger_apache2"
  allowed_hostnames allowed_hostnames
  other_hostnames other_hostnames  
  log_dir node[:apache][:log_dir]
  rails_env node.chef_environment
  enable_ssl app["enable_ssl"]
end

if ::File.exists?(::File.join(app['deploy_to'], "current"))
  d = resources(:deploy_revision => app['id'])
  # TODO for now the worker and web roles are tied together, this is a bug.
  # The app recipe needs to deploy only, and there needs to be a web role
  # TODO check which role(s) we're in here and change the command
  # appropriately, this should maybe be moved to a different recipe
  d.restart_command do
    service "apache2" do action :restart; end
    execute "god restart workers"
  end
end

apache_site "000-default" do
  enable false
end
