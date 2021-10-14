# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::install
class superset::install {

  # Use of SQLite will be deprecated at some point
  exec {'Initialize DB':
    command  => 'superset db upgrade',
    creates  => '/root/.superset/superset.db',
    cwd      => $superset::virtual_env_dir,
    path     => ["${superset::virtual_env_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    require  => [Python::Pip['apache-superset']]
  }

  if $superset::load_examples {
    exec {'Load Examples':
      command  => 'superset load_examples && touch .superset_examples_loaded',
      creates  => "${superset::virtual_env_dir}/.superset_examples_loaded",
      cwd      => $superset::virtual_env_dir,
      path     => ["${superset::virtual_env_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
      provider => 'shell',
      require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    }
  }


  $admin_hash = $superset::admin_config

  # Add parameters here
  exec { 'Create Admin User':
    command  => "superset fab create-admin --username ${admin_hash[username]} --firstname ${admin_hash[firstname]} --lastname ${admin_hash[lastname]} --password ${admin_hash[password]} --email ${admin_hash[email]}",
    unless   => 'superset fab list-users | grep admin',
    cwd      => $superset::virtual_env_dir,
    path     => ["${superset::virtual_env_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    provider => 'shell'
  }

  exec {'Initialize default roles and permissions':
    command  => 'superset init && touch .superset_init',
    creates  => "${superset::virtual_env_dir}/.superset_init",
    cwd      => $superset::virtual_env_dir,
    path     => ["${superset::virtual_env_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
  }
}
