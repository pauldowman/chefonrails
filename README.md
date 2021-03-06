Chef on Rails
=============

[https://github.com/pauldowman/chefonrails](https://github.com/pauldowman/chefonrails)

Chef on Rails is [Chef](http://www.opscode.com/chef/) cookbooks and
configuration for deploying a standard Rails app. It configures servers no
matter where they're hosted: your own data centre or any type of hosting
(including cloud providers such as EC2).

It configures freshly installed Ubuntu 11.04 "Natty" (the latest) servers,
automatically installing everything you need and deploying your Rails app.

It's based on [the official Opscode
cookbooks](https://github.com/opscode/cookbooks) but it's preconfigured and
opinionated, and numerous bugs have been fixed (for example, at the time of
this writing, deploying multiple apps with the default "application" recipe
[doesn't work and probably hasn't ever
worked](http://tickets.opscode.com/browse/CHEF-1406)

It will probably diverge significantly from the Opscode cookbooks (which IMHO
are messy and buggy anyway), towards what I think is the best setup for Rails.
E.g.  I'll likely switch to Nginx from Apache.

_I consider this very pre-release at this point, especially until I get some
documentation and detailed setup instructions done, which will be coming
soon..._


Quick start
-----------

TODO make this a lot better

1. Follow the [Opscode Getting Started Guide](http://help.opscode.com/kb/start) steps [1](http://help.opscode.com/kb/start/1-system-requirements-dependencies) and [2](http://help.opscode.com/kb/start/2-setting-up-your-user-environment) to set up your `.chef` directory with access to the hosted Chef server. Instead of creating your own Chef repository, you'll use this one.
1. Edit roles/*
1. Edit data_bags/app1.json
1. Rename data_bags/users/user1.json and edit it
1. run this command: `rake chefonrails:update_chef_server`
1. Start up a server instance (the following step assumes it is a staging server)
1. run this command (note that it's cut off when viewed on GitHub): `knife bootstrap <server hostname> -E staging -N <node name> -r 'role[base],role[app1_database_master],role[app1_redis_master],role[app1],role[app1_worker],role[app1_cron_jobs],role[app1_run_migrations],role[run_seed_data]' -x ubuntu -P ubuntu --template-file bootstrap/ubuntu11.04-gems.erb --sudo`

If you're using Amazon EC2 you'll want to select one of the [stock Ubuntu EC2
AMI's](http://uec-images.ubuntu.com/releases/11.04/release/) and use `-i <ssh-key>` instead of `-P ubuntu`.

More info on the `knife` command is available [here](http://help.opscode.com/kb/knife/knife-bootstrap).


Features
--------

TODO


Contributing
------------

Do you have an improvement to make? Please submit a pull request on GitHub or a
diff file.

The main author is [Paul Dowman](http://pauldowman.com/about) ([@pauldowman](http://twitter.com/pauldowman)).


