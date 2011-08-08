name "run_seed_data"
description "Run 'rake db:seed'"

run_list(
  "recipe[seed_data]"
)
