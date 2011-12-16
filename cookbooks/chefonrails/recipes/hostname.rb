#
# This recipe sets the hostname to the node name, useful for when you choose to
# set descriptive node names. It removes characters that are illegal in
# hostnames.
#

template "/etc/hosts" do
  source "hosts.erb"
  owner "root"
  group "root"
  mode 0644
  backup false
end

execute "Reset Hostname" do
  command "hostname --file /etc/hostname"
  action :nothing
end

file "/etc/hostname" do
  content node.name.gsub(/[^-[:alnum:]]/, '') # node names can have some chars that aren't allowed in hostnames
  notifies :run, resources(:execute => "Reset Hostname"), :immediately
end
