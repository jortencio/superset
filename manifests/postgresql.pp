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

    postgresql::server::db { $superset::pgsql_database:
      user     => $superset::pgsql_user,
      password => postgresql::postgresql_password($superset::pgsql_user, $superset::pgsql_password.unwrap),
    }
  }
}
