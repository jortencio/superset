# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {

  if $superset::manage_python {

    class { 'python' :
      ensure                => 'present',
      version               => lookup('superset::python_version', String),
      pip                   => 'present',
      dev                   => 'present',
      gunicorn              => 'absent',
      gunicorn_package_name => 'python3-gunicorn',
    }

    package { 'python3-wheel':
      ensure => 'installed',
    }
  }

  file { '/var/www':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  python::pyvenv { '/var/www/apache-superset':
    ensure     => present,
    version    => '3.9',
    owner      => $superset::user,
    group      => $superset::user,
    venv_dir   => '/var/www/apache-superset',
    systempkgs => false,
  }

  python::pip { 'apache-superset':
    ensure     => 'present',
    pkgname    => 'apache-superset',
    virtualenv => '/var/www/apache-superset',
  }

  python::pip { 'gunicorn':
    ensure     => 'present',
    pkgname    => 'gunicorn',
    virtualenv => '/var/www/apache-superset',
  }

  python::pip { 'gevent':
    ensure     => 'present',
    pkgname    => 'gevent',
    virtualenv => '/var/www/apache-superset',
  }

}
