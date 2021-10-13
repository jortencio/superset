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
    command => ". ${venv_dir}/bin/activate; superset db upgrade",
    creates => '/root/.superset/superset.db'
  }

  # Add parameters here
  exec { 'Create Admin User':
    command => ". ${venv_dir}/bin/activate; superset fab create-admin --username admin --firstname admin --lastname --admin --password password --email jason.ortencio@puppet.com",
    unless  => ". ${venv_dir}/bin/activate; superset fab list-users | grep admin"
  }
}
