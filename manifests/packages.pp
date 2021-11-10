# @summary
#
# Manages package dependencies for Superset
#
# @api private
#
class superset::packages {
  assert_private()


  $package_dependencies = lookup('superset::package_dependencies', Array)

  package { $package_dependencies:
    ensure => 'installed',
  }
}
