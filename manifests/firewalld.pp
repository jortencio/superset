# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::firewalld
class superset::firewalld {
  assert_private()

  class { 'firewalld': }

  firewalld_port { "Open the port used for superset: ${superset::port}":
    ensure   => present,
    zone     => 'public',
    port     => $superset::port,
    protocol => 'tcp',
    }

}
