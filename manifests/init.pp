# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset
class superset (
  String $virtual_env_dir,
  Boolean $manage_python,
  Boolean $load_examples,
  String $user,
  Hash $admin_config,
  Optional[Hash] $config = undef
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

  include superset::install

  include superset::service

  Class['superset::packages'] -> Class['superset::python'] -> Class['superset::config'] -> Class['superset::install'] -> Class['superset::service']
}
