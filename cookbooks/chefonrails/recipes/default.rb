tz = "America/Toronto" # TODO this should be an attribute
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
  only_if "test `who -s | grep ubuntu | wc -l` = 0"
end

