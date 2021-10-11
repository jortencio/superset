# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::packages
class superset::packages {
  $package_dependencies = lookup('superset::package_dependencies', Array)
  package { $package_dependencies:
    ensure => 'installed',
  }
}
