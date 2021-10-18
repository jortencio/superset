# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {

  if $superset::manage_python {

    class { 'python' :
      ensure   => 'present',
      version  => lookup('superset::python_version', String),
      pip      => 'present',
      dev      => 'present',
      gunicorn => 'absent',
    }

    if $facts[os][family] == 'Redhat' {
      package { 'python3-wheel':
        ensure => 'installed',
      }
    }
  }

  $venv_dir = lookup('superset::virtual_env_dir', String)

  python::pyvenv { $venv_dir:
    ensure     => present,
    version    => lookup('superset::python_version', String),
    owner      => $superset::user,
    group      => $superset::user,
    venv_dir   => $venv_dir,
    systempkgs => false,
  }

  # Install the pip packages required by superset into the virtual environment
  $venv_pip_packages = lookup('superset::python_venv_pips', Array[String])

  $venv_pip_packages.each | String $pkgname | {
    python::pip { $pkgname:
      ensure     => 'present',
      pkgname    => $pkgname,
      virtualenv => $venv_dir,
    }
  }
}
