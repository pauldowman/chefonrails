name "staging"
default_attributes :app_environment => "staging"

override_attributes "postfix" => {
  # Discard all mail that's not for your own domain
  #:discard_except_domain => "example.com"
}

