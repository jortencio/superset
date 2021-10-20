# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::postgresql
class superset::postgresql {
  class { 'postgresql::server':
  }

  postgresql::server::db { $superset::pgsql_config[database]:
    user     => $superset::pgsql_config[user],
    password => postgresql::postgresql_password($superset::pgsql_config[user], $superset::pgsql_config[password]),
  }
}
