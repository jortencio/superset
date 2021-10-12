# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
class superset::python {
  class { 'python' :
    ensure   => 'present',
    version  => lookup(superset::python_version),
    pip      => 'present',
    dev      => 'present',
    gunicorn => 'present'
  }
}
