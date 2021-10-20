# @summary
#
# Manages package dependencies for Superset
#
# @example
#   include superset::packages
class superset::packages {
  assert_private()


  $package_dependencies = lookup('superset::package_dependencies', Array)

  package { $package_dependencies:
    ensure => 'installed',
  }
}
