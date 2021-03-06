# @summary 
#
# Installs and configures the Python
#
# @api private
#
class superset::python {
  assert_private()

  if $superset::manage_python {

    class { 'python' :
      ensure   => 'present',
      version  => $superset::python_version,
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
}
