app = node.run_state[:current_app]

god_monitor "workers" do
  config "workers.god.erb"
  environment node.chef_environment
  rails_root "#{app['deploy_to']}/current"
  user app['owner']
  queues app['queues']
end
