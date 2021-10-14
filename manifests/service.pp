# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::service
class superset::service {

  $gunicorn_app_hash = $superset::config

  file { '/bin/superset.gunicorn':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => epp('superset/superset.gunicorn.epp',$superset::gunicorn_config),
  }

  file { '/usr/lib/systemd/system/superset.service':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('superset/superset.service.epp'),
  }
  ~> service {'superset':
    ensure => 'running',
  }
}
