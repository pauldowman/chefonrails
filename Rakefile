#
# Rakefile for Chef Server Repository
#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
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

require 'rubygems'
require 'chef'
require 'json'

# Load constants from rake config file.
require File.join(File.dirname(__FILE__), 'config', 'rake')

# Detect the version control system and assign to $vcs. Used by the update
# task in chef_repo.rake (below). The install task calls update, so this
# is run whenever the repo is installed.
#
# Comment out these lines to skip the update.

if File.directory?(File.join(TOPDIR, ".svn"))
  $vcs = :svn
elsif File.directory?(File.join(TOPDIR, ".git"))
  $vcs = :git
end

# Load common, useful tasks from Chef.
# rake -T to see the tasks this loads.

load 'chef/tasks/chef_repo.rake'

desc "Bundle a single cookbook for distribution"
task :bundle_cookbook => [ :metadata ]
task :bundle_cookbook, :cookbook do |t, args|
  tarball_name = "#{args.cookbook}.tar.gz"
  temp_dir = File.join(Dir.tmpdir, "chef-upload-cookbooks")
  temp_cookbook_dir = File.join(temp_dir, args.cookbook)
  tarball_dir = File.join(TOPDIR, "pkgs")
  FileUtils.mkdir_p(tarball_dir)
  FileUtils.mkdir(temp_dir)
  FileUtils.mkdir(temp_cookbook_dir)

  child_folders = [ "cookbooks/#{args.cookbook}", "site-cookbooks/#{args.cookbook}" ]
  child_folders.each do |folder|
    file_path = File.join(TOPDIR, folder, ".")
    FileUtils.cp_r(file_path, temp_cookbook_dir) if File.directory?(file_path)
  end

  system("tar", "-C", temp_dir, "-cvzf", File.join(tarball_dir, tarball_name), "./#{args.cookbook}")

  FileUtils.rm_rf temp_dir
end

namespace :chefonrails do |t|
  desc "Update the chef server with all cookbooks, data bags and roles"
  task :update_chef_server do  |t|
    puts "Updating environments..."
    Dir.glob("environments/*.rb").each do |f|
      run %{knife environment from file #{f}}
    end

    puts "Updating data bags..."
    run %{knife data bag create apps}
    run %{knife data bag from file apps data_bags/app1.json}
    run %{knife data bag create users}
    Dir.glob("data_bags/users/*.json").each do |f|
      run %{knife data bag from file users #{f}}
    end

    puts "Updating roles..."
    Rake::Task["roles"].invoke

    puts "Updating cookbooks..."
    run %{knife cookbook upload -a}
  end
end

desc "Run chef-client on all servers in the specified environment"
task :deploy, :environment, :use_cloud_hostname do |t, args |
  environment = args[:environment]
  use_cloud_hostname = args[:use_cloud_hostname]
  usage = <<-END
usage:
rake 'deploy[<environment>,<use_cloud_hostname>]'
e.g.:
  rake 'deploy[staging]'
or, for cloud environments, e.g. EC2:
  rake 'deploy[staging,true]'
END
  unless environment
    puts usage
    exit 1
  end

  if environment == "production"
    puts "****** Deploying to production! Pausing for 15 seconds... ******\n"
    sleep 15
  end

  run %{knife ssh 'chef_environment:#{environment}' 'sudo chef-client'#{use_cloud_hostname ? ' -a cloud.public_hostname' : nil}}
  run %{growlnotify 'Deployed to #{environment}' < /dev/null}
end

def run(command)
  result = system command
  raise("error, process exited with status #{$?.exitstatus}") unless result  
end


