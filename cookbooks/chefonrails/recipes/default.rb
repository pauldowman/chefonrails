# NOTE don't change this, there seems to be a bug with fail2ban
# where it doesn't match any log entries if localtime is different from
# the time that's recorded in auth.log. Setting a large findtime could be a
# workaround but it's probably best to just stick with UTC
tz = "UTC" # TODO this should be an attribute
execute "set timezone" do
  command "echo '#{tz}' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata"
  not_if "grep '#{tz}' /etc/timezone"
end

execute "apt-get upgrade" do
  command "apt-get -quy upgrade"
  command "apt-get clean"
end

package "htop" do
  action :install
end

file "/etc/gemrc" do
  mode "00644"
  content YAML.dump({"gem" => "--no-ri --no-rdoc"})
end

# remove the default user, but not if that user is still logged in
user "ubuntu" do
  action :remove
  only_if "test `ps aux | awk '{print $1}' | grep ubuntu | wc -l` = 0"
end

