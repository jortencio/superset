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
    command  => 'superset db upgrade',
    creates  => '/root/.superset/superset.db',
    cwd      => "${venv_dir}/bin",
    path     => "${venv_dir}/bin",
    provider => 'shell',
    require  => Class['superset::python']
  }

  # Add parameters here
  exec { 'Create Admin User':
    command  => 'superset fab create-admin --username admin --firstname admin --lastname --admin --password password --email jason.ortencio@puppet.com',
    unless   => 'superset fab list-users | grep admin',
    cwd      => "${venv_dir}/bin",
    path     => "${venv_dir}/bin",
    provider => 'shell',
    require  => [Class['superset::python'],Exec['Initialize DB']]
  }
}
