name "app1"
run_list(
  "recipe[apache2]",
  "recipe[apache2::mod_ssl]",
  "recipe[iptables::web]",
  "recipe[application]"
)

