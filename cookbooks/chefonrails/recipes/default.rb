tz = "America/Toronto"
execute "set timezone" do
  command "echo '#{tz}' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata"
  not_if "grep '#{tz}' /etc/timezone"
end

# execute "apt-get upgrade" do
#   command "apt-get -quy upgrade"
# end

package "htop" do
  action :install
end

file "/etc/gemrc" do
  mode "00644"
  content YAML.dump({"gem" => "--no-ri --no-rdoc"})
end

user "ubuntu" do
  action :remove
  not_if "test `whoami` = root"
end

