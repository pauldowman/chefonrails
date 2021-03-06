name "base"
description "Base role applied to all nodes."
run_list(
  "recipe[apt]",
  "recipe[build-essential]",
  "recipe[git]",
  "recipe[ntp]",
  "recipe[sudo]",
  "recipe[users::sysadmins]",
  "recipe[iptables]",
  "recipe[iptables::ssh]",
  "recipe[god]",
  "recipe[postfix]",
  "recipe[logwatch]",
  "recipe[fail2ban]",
  "recipe[chefonrails]",
  #"recipe[chefonrails::hostname]",
  "recipe[mail_monitor]",
  "recipe[screen]"
)

default_attributes "ntp" => {
  "servers" => ["0.pool.ntp.org", "1.pool.ntp.org"]
}
 
override_attributes "postfix" => {
  # Uncomment the following to relay via an SMTP hosting service such as SendGrid
  # "relayhost" => "[smtp.sendgrid.net]:587", 
  # "smtp_connection_cache_destinations" => "smtp.sendgrid.net",
  # "smtp_sasl_auth_enable" => "yes",
  # "smtp_sasl_password_maps" => "static:smtp_userid:password",
  # "smtp_sasl_security_options" => "noanonymous",
  # "smtpd_use_tls" => "no",
  # "soft_bounce" => "yes"
}

