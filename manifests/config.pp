# @summary
#
# Manages the superset_config.py configuration file
#
# @api private
# 
class superset::config {
  assert_private()

  if $superset::manage_config {
    file { "${superset::install_dir}/apache-superset/superset_config.py":
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0644',
      content => epp('superset/superset_config.py.epp'),
      notify  => Service['superset'],
    }
  }
}
