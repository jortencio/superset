# @summary
#
# Superset main class that has parameters for customising the installation and configuration of Apache Superset
# 
# lint:ignore:140chars
#
# @example
#   include superset
#
# @param install_dir
#   The directory that a Python Virtual Environment will be created under and where Superset will be installed
#
# @param port
#   The port that that superset will be served from. Default: 8088
#
# @param user
#   The owner of any file/folders created for the Superset installation
#
# @param load_examples
#   Option for loading example charts and data.  Default: false
#
# @param manage_python
#   Option for managing the installation of python.  Default: true
#
# @param manage_webserver
#   Option for managing a gunicorn webserver.  Default: true 
#
# @param manage_db
#   Option for managing a Postgresql db back-end.  Default: true 
#
# @param manage_firewall
#   Option for managing firewall (RHEL8 firwalld).  Default: false
#
# @param admin_config
#   Overide option for superset admin user data (username, first name, last name, email, password).
#   Default: 
#   - username: admin 
#   - password: password
#
# @param gunicorn_config
#   Overide option for gunicorn.
#   Default:
#   - install_dir: "%{lookup('superset::install_dir')}"
#   - workers: 10
#   - timeout: 120
#   - bind: "0.0.0.0:%{lookup('superset::port')}"
#   - limit_request_line: 0
#   - limit_request_field_size: 0
#   - statsd_host: localhost:8125
#
# @param superset_config
#   Optional parameter for overiding the superset default configuration
#   Available options include:
#   - row_limit
#   - superset_webserver_port
#   - secret_key
#   - sqlalchemy_database_uri
#   - wtf_csrf_enabled
#   - wtf_csrf_exempt_list
#   - wtf_csrf_time_limit
#   - mapbox_api_key
#
# 
#
# lint:ignore:parameter_order
class superset (
  String $install_dir,
  Integer $port,
  String  $user,
  Boolean $load_examples,
  Boolean $manage_python,
  Boolean $manage_webserver,
  Boolean $manage_db,
  Boolean $manage_firewall,
  Hash    $admin_config,
  Hash    $gunicorn_config,
  Hash    $app_config,
  Hash    $pgsql_config
) {
  # lint:endignore

  # Install package dependencies 
  include superset::packages

  # Configure Python
  include superset::python

  # Configure Python Virtual Environment and install Superset
  include superset::install

  # Configure Superset
  include superset::config

  # Install Postgresql database
  include superset::postgresql

  # Initialise Superset Backend Database
  include superset::init_db

  # Configure and start Gunicorn Service
  include superset::service

  # Manage the firwall
  if $manage_firewall {
    include superset::firewalld
  }

  Class['superset::packages'] -> Class['superset::python'] -> Class['superset::install']-> Class['superset::config'] -> Class['superset::postgresql'] -> Class['superset::init_db'] -> Class['superset::service']
}
# lint:endignore
