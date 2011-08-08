name "app1_database_master"
run_list(
  "recipe[mysql::server]",
  #"recipe[database::ebs_volume]",
  "recipe[database::master]"
)
