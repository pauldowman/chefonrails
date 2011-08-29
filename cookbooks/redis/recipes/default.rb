package "redis-server" do
  action :install
end

service "redis" do
  service_name "redis-server"
  supports :status => true, :start => true, :stop => true, :restart => true, :reload => true
  action :nothing
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "0644"
  notifies :restart, resources(:service => "redis"), :immediately
end

