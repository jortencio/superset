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
# @param admin_username
#   Parameter for setting the admin user username
#
# @param admin_password
#   Sensitive parameter for setting the admin user password
#
# @param admin_firstname
#   Parameter for setting the admin user first name
#
# @param admin_lastname
#   Parameter for setting the admin user last name
#
# @param admin_email
#   Parameter for setting the admin user email address
#
# @param gunicorn_install_dir
#   Overide for gunicorn install_dir option.
#
# @param gunicorn_workers
#   Overide for gunicorn workers option.
#
# @param gunicorn_worker_class
#   Overide for gunicorn worker_class option.
#
# @param gunicorn_timeout
#   Overide for gunicorn timeout option.
#
# @param gunicorn_bind
#   Overide for gunicorn bind option.
#
# @param gunicorn_limit_request_line
#   Overide for gunicorn limit_request_line option.
#
# @param gunicorn_limit_request_field_size
#   Overide for gunicorn limit_request_field_size option.
#
# @param gunicorn_statsd_host
#   Overide for gunicorn statsd_host option.
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
# @param pgsql_database
#   Overide option for overiding the default postgresql database 
#
# @param pgsql_user
#   Overide option for overiding the default postgresql user
#
# @param pgsql_password
#   Overide option for overiding the default postgresql password 
#
# @param pgsql_host
#   Overide option for overiding the default postgresql host
#
# @param pgsql_port
#   Overide option for overiding the default postgresql port
#
# @param python_version
#   Overide option for setting the Python version if it will be managed by this module
#
# @param python_pip
#   Parameter for setting whether the ensure python-pip is present, absent or latest
#
# @param python_dev
#   Parameter for setting whether the ensure python-dev is present, absent or latest
#
# @param python_venv
#   Parameter for setting whether the ensure python-venv is present, absent or latest
#
# @param db_drivers
#   Overide option for setting database drivers (python database driver packages) to be installed
#
# lint:ignore:parameter_order
class superset (
  String                                                $install_dir = '/home/superset',
  Variant[Enum['present','absent','latest'], String[1]] $version = '2.1.0',
  Array[String]                                         $additional_python_lib = [],
  Integer                                               $port = 8088,
  String                                                $user = 'superset',
  Boolean                                               $load_examples = false,
  Boolean                                               $manage_python = true,
  Boolean                                               $manage_webserver = true,
  Boolean                                               $manage_db = true,
  Boolean                                               $manage_firewall = false,
  String                                                $admin_username = 'admin',
  Sensitive[String]                                     $admin_password = Sensitive('password'),
  String                                                $admin_firstname = 'admin',
  String                                                $admin_lastname = 'admin',
  String                                                $admin_email = 'admin@mycompany.com',
  String                                                $gunicorn_install_dir = '/home/superset',
  String                                                $gunicorn_worker_class = 'gevent',
  Integer                                               $gunicorn_workers = 10,
  Integer                                               $gunicorn_timeout = 120,
  String                                                $gunicorn_bind = '0.0.0.0:8088',
  Integer                                               $gunicorn_limit_request_line = 0,
  Integer                                               $gunicorn_limit_request_field_size = 0,
  String                                                $gunicorn_statsd_host = 'localhost:8125',
  Boolean                                               $manage_config = true,
  Optional[Integer]                                     $config_row_limit = undef,
  Optional[Integer]                                     $config_webserver_port = undef,
  Sensitive[String]                                     $config_secret_key = Sensitive('53cR37K3y'),
  Optional[String]                                      $config_sqlalchemy_database_uri = undef,
  Optional[Boolean]                                     $config_wtf_csrf_enabled = undef,
  Optional[Array[String]]                               $config_wtf_csrf_exempt_list = undef,
  Optional[Integer]                                     $config_wtf_csrf_time_limit = undef,
  Optional[String]                                      $config_mapbox_api_key = undef,
  String                                                $pgsql_database = 'superset',
  String                                                $pgsql_user = 'superset',
  Sensitive[String]                                     $pgsql_password = Sensitive('password'),
  String                                                $pgsql_host = 'localhost',
  Integer                                               $pgsql_port = 5432,
  String                                                $python_version = 'python38',
  Enum['present','absent','latest']                     $python_pip = 'present',
  Enum['present','absent','latest']                     $python_dev = 'present',
  Enum['present','absent','latest']                     $python_venv = 'absent',
  Array[String]                                         $db_drivers = ['psycopg2'],
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
