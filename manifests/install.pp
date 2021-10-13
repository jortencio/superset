# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::install
class superset::install {
  include superset::python

  # Set up for development instance only

  $venv_dir = lookup('superset::virtual_env_dir', String)

  # Use of SQLite will be deprecated at some point
  exec {'Initialize DB':
    command  => 'superset db upgrade && superset load_examples && superset init',
    creates  => '/root/.superset/superset.db',
    cwd      => $venv_dir,
    path     => ["${venv_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    require  => Class['superset::python']
  }

  exec {'Load Examples':
    command  => 'superset load_examples && touch .superset_examples_loaded',
    creates  => "${venv_dir}/.superset_examples_loaded",
    cwd      => $venv_dir,
    path     => ["${venv_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    require  => [Class['superset::python'],Exec['Initialize DB']],
  }

  # Add parameters here
  exec { 'Create Admin User':
    command  => 'superset fab create-admin --username admin --firstname admin --lastname --admin --password password --email jason.ortencio@puppet.com',
    unless   => 'superset fab list-users | grep admin',
    cwd      => $venv_dir,
    path     => ["${venv_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    require  => [Class['superset::python'],Exec['Initialize DB']],
    provider => 'shell'
  }

  exec {'Initialize default roles and permissions':
    command  => 'superset init && touch .superset_init',
    creates  => "${venv_dir}/.superset_init",
    cwd      => $venv_dir,
    path     => ["${venv_dir}/bin",'/usr/local/bin','/usr/bin','/bin', '/usr/sbin'],
    provider => 'shell',
    require  => [Class['superset::python'],Exec['Initialize DB']],
  }
}
