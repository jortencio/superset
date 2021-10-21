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
  $set_config_path = "export SUPERSET_CONFIG_PATH=${superset_dir}/superset_config.py;"

  # Use of SQLite will be deprecated at some point
  exec {'Initialize DB':
    command  => "${set_config_path} superset db upgrade > .superset_db_upgrade",
    creates  => "${superset_dir}/.superset_db_upgrade", #TODO: Need to fix this condition as it may be overiden in config / replaced with a database
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin","${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset']]
  }

  if $superset::load_examples {
    exec {'Load Examples with test data':
      command  => "${set_config_path} superset load_examples -t > .superset_examples_loaded_t",  # Only added -t option because it errors without it.  Need to test against non SQLlite database
      creates  => "${superset_dir}/.superset_examples_loaded_t",
      cwd      => $superset_dir,
      path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
      provider => 'shell',
      user     => $superset::user,
      require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    }
  }


  $admin_hash = $superset::admin_config

  # Add parameters here
  exec { 'Create Admin User':
    command  => "${set_config_path} superset fab create-admin --username ${admin_hash[username]} --firstname ${admin_hash[firstname]} --lastname ${admin_hash[lastname]} --password ${admin_hash[password]} --email ${admin_hash[email]} > .create_admin",
    unless   => "${set_config_path} superset fab list-users | grep ${admin_hash[username]}", #TODO: Improve condition for this
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    user     => $superset::user,
    provider => 'shell'
  }

  exec {'Initialize default roles and permissions':
    command  => "${set_config_path} superset init > .superset_init",
    creates  => "${superset_dir}/.superset_init",
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
  }
}
# lint:endignore
