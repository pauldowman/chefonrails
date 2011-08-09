app = node.run_state[:current_app]
app_name = app['id']
run_as = app['owner']
command_line = "export PATH=\"/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin\";bash -c 'cd #{app[:deploy_to]}/current && RAILS_ENV=#{node.chef_environment} bundle exec rake -s chefonrails:cron:%s'"

cron "#{app_name} hourly" do
  minute "0"
  user run_as  
  command sprintf(command_line, "hourly") 
end

cron "#{app_name} daily" do
  hour "6"
  minute "0"
  user run_as
  command sprintf(command_line, "daily")
end

cron "#{app_name} weekly" do
  weekday "0"
  hour "0"
  minute "0"
  user run_as
  command sprintf(command_line, "weekly")
end

cron "#{app_name} monthly" do
  day "0"
  weekday "0"
  hour "0"
  minute "0"
  user run_as
  command sprintf(command_line, "monthly")
end

