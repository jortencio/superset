# @summary
#
# Manages the superset_config.py configuration file
#
# @example
#   include superset::config
class superset::config {
  assert_private()

  if $superset::app_config {
    file { "${superset::install_dir}/superset_config.py":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('superset/superset_config.py.epp',$superset::app_config),
      notify  => Service['superset']
    }
  }
}
