default[:postfix][:mail_type]  = "client"
default[:postfix][:myhostname] = fqdn
default[:postfix][:mydomain]   = domain
default[:postfix][:myorigin]   = "$myhostname"
default[:postfix][:relayhost]  = ""
default[:postfix][:mail_relay_networks] = "127.0.0.0/8"
default[:postfix][:discard_except_domain] = nil
default[:postfix][:forward_system_mail_to] = "admin@example.com" # where you want root mail delivered

default[:postfix][:smtpd_use_tls] = "yes"
default[:postfix][:smtpd_tls_cert_file] = "/etc/ssl/certs/ssl-cert-snakeoil.pem"
default[:postfix][:smtpd_tls_key_file] = "/etc/ssl/private/ssl-cert-snakeoil.key"
default[:postfix][:smtp_sasl_auth_enable] = "no"
default[:postfix][:smtp_sasl_password_maps]    = "hash:/etc/postfix/sasl_passwd"
default[:postfix][:smtp_sasl_security_options] = "noanonymous"
default[:postfix][:smtp_tls_cafile] = ""
default[:postfix][:smtp_tls_capath] = "/etc/ssl/certs"
default[:postfix][:smtp_use_tls]    = "yes"
default[:postfix][:smtp_sasl_user_name] = ""
default[:postfix][:smtp_sasl_passwd]    = ""
default[:postfix][:soft_bounce]    = "no"
default[:postfix][:smtp_connection_cache_destinations]    = ""

