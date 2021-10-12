# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {

  $superset_dir=lookup('superset::virtual_env', String)

  file { $superset_dir:
    ensure  => directory,
    recurse => true,
    owner   => lookup(superset::user, String),
    group   => lookup(superset::user, String),
    mode    => '0644'
  }

  class { 'python' :
    ensure   => 'present',
    version  => lookup(superset::python_version),
    pip      => 'present',
    dev      => 'present',
    gunicorn => 'absent'
  }
}
