# @summary A short summary of the purpose of this class
#
# Configures the python component required by superset
#
# @example
#   include superset::python
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
