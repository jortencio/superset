# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {

  $python_pips = lookup('superset::python_pips')
  $python_venvs = lookup('superset::python_pyvenvs')

  class { 'python' :
    ensure   => 'absent',
    version  => lookup('superset::python_version', String),
    pip      => 'absent',
    dev      => 'absent',
    gunicorn => 'absent',
#    python_pips    => $python_pips,
#    python_pyvenvs => $python_venvs,
  }

  $package_uninstall = ['python3-wheel','python3-pip','python3-devel']

  package { $package_uninstall:
    ensure => 'absent',
  }
}
