# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::install
class superset::install {

  $superset_dir = "${superset::install_dir}/apache-superset"

  # Use of SQLite will be deprecated at some point
  exec {'Initialize DB':
    command  => 'superset db upgrade',
    creates  => "/home/${superset::user}/.superset/superset.db", #TODO: Need to fix this condition as it may be overiden in config / replaced with a database
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset']]
  }

  notify { 'Load Examples':
    message => "Load examples is set to: ${$superset::load_examples}"
  }

  if $superset::load_examples {
    exec {'Load Examples':
      command  => 'superset load_examples && touch .superset_examples_loaded',
      creates  => "${superset_dir}/.superset_examples_loaded",
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
    command  => "superset fab create-admin --username ${admin_hash[username]} --firstname ${admin_hash[firstname]} --lastname ${admin_hash[lastname]} --password ${admin_hash[password]} --email ${admin_hash[email]}",
    unless   => "superset fab list-users | grep ${admin_hash[username]}", #TODO: Improve condition for this
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
    user     => $superset::user,
    provider => 'shell'
  }

  exec {'Initialize default roles and permissions':
    command  => 'superset init && touch .superset_init',
    creates  => "${superset_dir}/.superset_init",
    cwd      => $superset_dir,
    path     => ["${superset_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    user     => $superset::user,
    require  => [Python::Pip['apache-superset'],Exec['Initialize DB']],
  }
}
