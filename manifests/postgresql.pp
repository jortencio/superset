# @summary
#
# Manages a basic postgresql backend for superset
#
# @api private
#
class superset::postgresql {
  if $superset::manage_db {
    class { 'postgresql::server':
    }

    postgresql::server::db { $superset::pgsql_config[database]:
      user     => $superset::pgsql_config[user],
      password => postgresql::postgresql_password($superset::pgsql_config[user], $superset::pgsql_config[password]),
    }
  }
}
