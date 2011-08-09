execute "rake_db_seed" do
  command "bundle exec rake db:seed"
  environment 'RAILS_ENV' => node.chef_environment
  cwd "/srv/app1/current" # TODO determine the app name
  only_if { node.chef_environment != 'production' }
end

# Make sure this only runs once, remove the role after it runs.
ruby_block "remove_seed_data_role" do
  block do
    if node.role?("run_seed_data")
      Chef::Log.info("Removing role[run_seed_data]")
      node.run_list.remove("role[run_seed_data]")
    end
  end
end

