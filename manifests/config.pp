# @summary
#
# Manages the superset_config.py configuration file
#
# @example
#   include superset::config
class superset::config {
  assert_private()

  if $superset::app_config {
    file { "${superset::install_dir}/apache-superset/superset_config.py":
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0644',
      content => epp('superset/superset_config.py.epp',$superset::app_config),
      notify  => Service['superset']
    }
  }
}
