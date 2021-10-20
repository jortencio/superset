# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::install
class superset::install {

  $superset_venv_dir = "${superset::install_dir}/apache-superset"

  $venv_python_ver = lookup('superset::python_version', String) ? {
    /\Apython([0-9])([0-9]+)/    => "${1}.${2}",
    /\Apython?([0-9])/           => "${1}",
    /\Arh-python([0-9])([0-9]+)/ => "${1}.${2}",
    /\Arh-python([0-9])/         => "${1}",
    default                      => lookup('superset::python_version', String),
  }

  # Create virtual environment for apache superset
  python::pyvenv { $superset_venv_dir:
    ensure     => present,
    version    => $venv_python_ver,
    owner      => $superset::user,
    group      => $superset::user,
    venv_dir   => $superset_venv_dir,
    systempkgs => false,
  }

  # Install apache superset
  python::pip { 'apache-superset':
      ensure     => 'present',
      pkgname    => 'apache-superset',
      virtualenv => $superset_venv_dir,
      owner      => $superset::user,
      group      => $superset::user,
  }

  if $superset::manage_webserver {
    $webserver_venv_pip_pkg = ['gunicorn', 'gevent']
    $webserver_venv_pip_pkg.each | String $pkgname | {
      python::pip { $pkgname:
        ensure     => 'present',
        pkgname    => $pkgname,
        virtualenv => $superset_venv_dir,
        owner      => $superset::user,
        group      => $superset::user,
      }
    }
  }
}
