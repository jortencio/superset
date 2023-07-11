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
# @param version
#   The version of Apache Superset to install.
#
# @param additional_python_lib
#   Array of additional python libraries to install.
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
# @param manage_config
#  Boolean for setting whether to manage the config file superset_config.py
#
# @param config_row_limit
#  Optional setting for setting ROW_LIMIT in superset_config.py
#
# @param config_webserver_port
#  Optional setting for setting SUPERSET_WEBSERVER_PORT in superset_config.py
#
# @param config_secret_key
#  Sensitive parameter for setting SECRET_KEY in superset_config.py
#
# @param config_sqlalchemy_database_uri
#  Optional setting for setting SQLALCHEMY_DATABASE_URI in superset_config.py
#
# @param config_wtf_csrf_enabled
#  Optional setting for setting WTF_CSRF_ENABLED in superset_config.py
#
# @param config_wtf_csrf_exempt_list
#  Optional setting for setting WTF_CSRF_EXEMPT_LIST in superset_config.py
#
# @param config_wtf_csrf_time_limit
#  Optional setting for setting WTF_CSRF_TIME_LIMIT in superset_config.py
#
# @param config_mapbox_api_key
#  Optional setting for setting MAPBOX_API_KEY in superset_config.py
#
# @param pgsql_config
#   Overide option for overiding the default postgresql configuration
#   Available options include:
#   - database
#   - user
#   - password
#   - host
#   - port
#
# @param python_version
#   Overide option for setting the Python version if it will be managed by this module
#
# @param db_drivers
#   Overide option for setting database drivers (python database driver packages) to be installed
#
# lint:ignore:parameter_order
class superset (
  String                                                $install_dir,
  Variant[Enum['present','absent','latest'], String[1]] $version = 'present',
  Array[String]                                         $additional_python_lib = [],
  Integer                                               $port,
  String                                                $user,
  Boolean                                               $load_examples,
  Boolean                                               $manage_python,
  Boolean                                               $manage_webserver,
  Boolean                                               $manage_db,
  Boolean                                               $manage_firewall,
  Hash                                                  $admin_config,
  Hash                                                  $gunicorn_config,
  Boolean                                               $manage_config = true,
  Optional[Integer]                                     $config_row_limit = undef,
  Optional[Integer]                                     $config_webserver_port = undef,
  Sensitive[String]                                     $config_secret_key = Sensitive('53cR37K3y'),
  Optional[String]                                      $config_sqlalchemy_database_uri = undef,
  Optional[Boolean]                                     $config_wtf_csrf_enabled = undef,
  Optional[Array[String]]                               $config_wtf_csrf_exempt_list = undef,
  Optional[Integer]                                     $config_wtf_csrf_time_limit = undef,
  Optional[String]                                      $config_mapbox_api_key = undef,
  Hash                                                  $pgsql_config,
  String                                                $python_version,
  Array[String]                                         $db_drivers,
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

  Class['superset::packages']
  -> Class['superset::python']
  -> Class['superset::install']
  -> Class['superset::config']
  -> Class['superset::postgresql']
  -> Class['superset::init_db']
  -> Class['superset::service']
}
# lint:endignore
