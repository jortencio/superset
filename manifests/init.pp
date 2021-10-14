# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset
class superset (
  String  $virtual_env_dir,
  Boolean $manage_python,
  Boolean $load_examples,
) {

  $superset_user = lookup('superset::user', String)

  group { $superset_user :
    ensure => present
  }

  user { $superset_user:
    ensure     => present,
    gid        => $superset_user,
    managehome => true
  }

  #Install package dependencies 
  include superset::packages

  #Configure Python
  include superset::python

  include superset::config

  include superset::install

  include superset::service

  Class['superset::packages'] -> Class['superset::python'] -> Class['superset::config'] -> Class['superset::install'] -> Class['superset::service']
}
