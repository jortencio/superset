# @summary
#
# Configures and manages Superset service (using Gunicorn)
#
# @example
#   include superset::service
class superset::service {
  assert_private()

  if $superset::manage_webserver {

    file { '/bin/superset.gunicorn':
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0755',
      content => epp('superset/superset.gunicorn.epp',$superset::gunicorn_config),
    }

    file { '/usr/lib/systemd/system/superset.service':
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0644',
      content => epp('superset/superset.service.epp', { user => $superset::user }),
    }

    service {'superset':
      ensure    => 'running',
      subscribe => [File['/bin/superset.gunicorn'],
                    File['/usr/lib/systemd/system/superset.service']]
    }
  }
}
