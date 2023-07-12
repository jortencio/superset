# @summary
#
# Initialises the superset db with an admin user, default roles and default permissions.  Can also optionally load examples
#
# lint:ignore:140chars
#
# @api private
# 
class superset::init_db {
  assert_private()

  $superset_dir = "${superset::install_dir}/apache-superset"
  $set_env_var = "export SUPERSET_CONFIG_PATH=${superset_dir}/superset_config.py; export FLASK_APP=${superset_dir}/bin/superset;"

  # Use of SQLite will be deprecated at some point
  exec { 'Initialize DB':
    command  => "${set_env_var} superset db upgrade > .superset_db_upgrade",
    creates  => "${superset_dir}/.superset_db_upgrade", #TODO: Need to fix this condition as it may be overiden in config / replaced with a database
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin","${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset']],
  }

  if $superset::load_examples {
    exec { 'Load Examples with test data':
      command  => "${set_env_var} superset load_examples > .superset_examples_loaded",
      creates  => "${superset_dir}/.superset_examples_loaded",
      cwd      => $superset_dir,
      path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
      provider => 'shell',
      user     => $superset::user,
      require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    }
  }

  # Add parameters here
  exec { 'Create Admin User':
    command  => "${set_env_var} superset fab create-admin --username ${superset::admin_username} --firstname ${superset::admin_firstname} --lastname ${superset::admin_lastname} --password ${superset::admin_password.unwrap} --email ${superset::admin_email} > .create_admin",
    unless   => "${set_env_var} superset fab list-users | grep ${superset::admin_username}", #TODO: Improve condition for this
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    user     => $superset::user,
    provider => 'shell',
  }

  exec { 'Initialize default roles and permissions':
    command  => "${set_env_var} superset init > .superset_init",
    creates  => "${superset_dir}/.superset_init",
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
  }
}
# lint:endignore
