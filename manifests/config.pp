# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::config
class superset::config {
  assert_private()

  if $superset::config {
    file { "${superset::install_dir}/superset_config.py":
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => epp('superset/superset_config.py.epp',$superset::config),
      notify  => Service['superset']
    }
  }
}
