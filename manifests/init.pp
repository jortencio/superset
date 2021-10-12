# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset
class superset {

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

  include superset::install
}
