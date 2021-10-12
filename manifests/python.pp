# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {
  class { 'python' :
    ensure     => 'present',
    version    => 'system',
    dev        => 'present',
    virtualenv => 'present'
  }

  $virtualenv_path = lookup('superset::venv_path', String)

  python::pip { 'apache-superset':
    ensure     => 'present',
    pkgname    => 'apache-superset',
    virtualenv => $virtualenv_path
  }

  $superset_user ='superset'

  python::virtualenv { $virtualenv_path :
    ensure   => present,
    version  => 'system',
    venv_dir => "/home/${superset_user}/virtualenvs",
    owner    => $superset_user,
    group    => $superset_user,
    cwd      => $virtualenv_path,
  }
}
