app = node.run_state[:current_app]
app_name = app['id']
run_as = app['owner']
command_line = "export PATH=\"/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin\";bash -c 'cd #{app[:deploy_to]}/current && RAILS_ENV=#{node.chef_environment} bundle exec rake -s chefonrails:cron:%s'"

cron "#{app_name} every 5 minutes" do
  minute "*/5"
  user run_as  
  command sprintf(command_line, "every_5_minutes") 
end

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


# check app & apache logs:

cookbook_file "/usr/local/bin/check_logs" do
  source "check_logs"
  owner "root"
  group "root"
  mode 0755
end

cron "check_logs" do
  minute "10,25,40,55" # every 15 minutes but not exactly on the hour
  user "root"
  command "/usr/local/bin/check_logs"
end

cookbook_file "/usr/local/bin/check_logs_daily" do
  source "check_logs_daily"
  owner "root"
  group "root"
  mode 0755
end

cron "check_logs_daily" do
  minute "0"
  hour "6" # NOTE logrotate runs from /etc/cron.daily which starts at 06:25
  user "root"
  command "/usr/local/bin/check_logs_daily"
end

