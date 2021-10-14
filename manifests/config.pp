# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::config
class superset::config {

  file { "${superset::virtual_env_dir}/superset_config.py":
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }
}
