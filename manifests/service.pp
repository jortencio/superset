# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include superset::service
class superset::service {

  file { '/bin/superset.gunicorn':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
    source => 'puppet:///modules/superset/superset.gunicorn',
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
