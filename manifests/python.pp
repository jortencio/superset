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
      ensure  => 'present',
      version => $superset::python_version,
      pip     => $superset::python_pip,
      dev     => $superset::python_dev,
      venv    => $superset::python_venv,
    }
  }
}
