# @summary 
#
# Installs and configures the Python
#
# @api private
#
class superset::python {
  assert_private()

  $python_ver = lookup('superset::python_version', String)


  if $superset::manage_python {

    class { 'python' :
      ensure   => 'present',
      version  => $python_ver,
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
