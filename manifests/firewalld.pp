# @summary
#
# Manages firewalld service and opens Superset port
#
# @api private
#  
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
