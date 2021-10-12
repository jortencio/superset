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
    ensure                => 'present',
    version               => lookup('superset::python_version', String),
    pip                   => 'present',
    dev                   => 'present',
    gunicorn              => 'absent',
    gunicorn_package_name => 'python3-gunicorn',
    python_pips           => $python_pips,
    python_pyvenvs        => $python_venvs,
  }
}
