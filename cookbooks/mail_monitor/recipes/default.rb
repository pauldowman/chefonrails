package "logtail" do
  action :install
end

template "/usr/local/bin/emergency_mail_sender" do
  source "emergency_mail_sender.erb"
  owner "root"
  group "root"
  mode 0755
end

cookbook_file "/usr/local/bin/check_mail_logs" do
  source "check_mail_logs"
  owner "root"
  group "root"
  mode 0755
end

cron "check_mail_logs" do
  minute "5,20,35,50" # every 15 minutes, slightly offset from the hour
  command "/usr/local/bin/check_mail_logs"
end
