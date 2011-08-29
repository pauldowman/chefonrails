name "app1_worker"
run_list(
  "recipe[application]",
  "recipe[application::worker]"
)
