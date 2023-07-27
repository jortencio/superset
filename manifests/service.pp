# @summary
#
# Configures and manages Superset service (using Gunicorn)
#
# @api private
#
class superset::service {
  assert_private()

  if $superset::manage_webserver {
    file { '/bin/superset.gunicorn':
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0755',
      content => epp('superset/superset.gunicorn.epp', {
          install_dir              => $superset::gunicorn_install_dir,
          workers                  => $superset::gunicorn_workers,
          worker_class             => $superset::gunicorn_worker_class,
          bind                     => $superset::gunicorn_bind,
          timeout                  => $superset::gunicorn_timeout,
          limit_request_line       => $superset::gunicorn_limit_request_line,
          limit_request_field_size => $superset::gunicorn_limit_request_field_size,
          statsd_host              => $superset::gunicorn_statsd_host,
      }),
    }

    file { '/usr/lib/systemd/system/superset.service':
      ensure  => file,
      owner   => $superset::user,
      group   => $superset::user,
      mode    => '0644',
      content => epp('superset/superset.service.epp', { user => $superset::user }),
    }

    service { 'superset':
      ensure    => 'running',
      subscribe => [
        File['/bin/superset.gunicorn'],
        File['/usr/lib/systemd/system/superset.service'],
      ],
    }
  }
}
