# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset
class superset (
  String $install_dir,
  Integer $port,
  Boolean $manage_python,
  Boolean $manage_webserver,
  Boolean $load_examples,
  String $user,
  Boolean $manage_firewall,
  Optional[Hash] $admin_config,
  Optional[Hash] $config = undef,
  Optional[Hash] $gunicorn_config,
) {

  group { $user :
    ensure => present
  }

  user { $user:
    ensure     => present,
    gid        => $user,
    managehome => true
  }

  #Install package dependencies 
  include superset::packages

  #Configure Python
  include superset::python

  include superset::config

  include superset::init_db

  include superset::service

  if $manage_firewall {
    include superset::firewalld
  }

  Class['superset::packages'] -> Class['superset::python'] -> Class['superset::config'] -> Class['superset::init_db'] -> Class['superset::service']
}
