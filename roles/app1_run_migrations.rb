name "app1_run_migrations"

override_attributes "apps" => {
  "app1" => {
    "production" => { "run_migrations" => true },
    "staging" => { "run_migrations" => true }
  }
}
