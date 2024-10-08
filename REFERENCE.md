# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`superset`](#superset): Superset main class that has parameters for customising the installation and configuration of Apache Superset  lint:ignore:140chars  lint:ign

#### Private Classes

* `superset::config`: Manages the superset_config.py configuration file
* `superset::firewalld`: Manages firewalld service and opens Superset port
* `superset::init_db`: Initialises the superset db with an admin user, default roles and default permissions.  Can also optionally load examples  lint:ignore:140cha
* `superset::install`: Creates the Superset user and configures a Python virtual environment for installing Apache Superset and its dependent Python libraries
* `superset::packages`: Manages package dependencies for Superset
* `superset::postgresql`: Manages a basic postgresql backend for superset
* `superset::python`: Installs and configures the Python
* `superset::service`: Configures and manages Superset service (using Gunicorn)

### Tasks

* [`delete_superset_venv`](#delete_superset_venv): A task for deleting the Apache Superset virtual environment directory

## Classes

### <a name="superset"></a>`superset`

Superset main class that has parameters for customising the installation and configuration of Apache Superset

lint:ignore:140chars

lint:ignore:parameter_order

#### Examples

##### 

```puppet
include superset
```

#### Parameters

The following parameters are available in the `superset` class:

* [`install_dir`](#-superset--install_dir)
* [`version`](#-superset--version)
* [`additional_python_lib`](#-superset--additional_python_lib)
* [`port`](#-superset--port)
* [`user`](#-superset--user)
* [`load_examples`](#-superset--load_examples)
* [`manage_python`](#-superset--manage_python)
* [`manage_webserver`](#-superset--manage_webserver)
* [`manage_db`](#-superset--manage_db)
* [`manage_firewall`](#-superset--manage_firewall)
* [`admin_username`](#-superset--admin_username)
* [`admin_password`](#-superset--admin_password)
* [`admin_firstname`](#-superset--admin_firstname)
* [`admin_lastname`](#-superset--admin_lastname)
* [`admin_email`](#-superset--admin_email)
* [`gunicorn_install_dir`](#-superset--gunicorn_install_dir)
* [`gunicorn_workers`](#-superset--gunicorn_workers)
* [`gunicorn_worker_class`](#-superset--gunicorn_worker_class)
* [`gunicorn_timeout`](#-superset--gunicorn_timeout)
* [`gunicorn_bind`](#-superset--gunicorn_bind)
* [`gunicorn_limit_request_line`](#-superset--gunicorn_limit_request_line)
* [`gunicorn_limit_request_field_size`](#-superset--gunicorn_limit_request_field_size)
* [`gunicorn_statsd_host`](#-superset--gunicorn_statsd_host)
* [`manage_config`](#-superset--manage_config)
* [`config_row_limit`](#-superset--config_row_limit)
* [`config_webserver_port`](#-superset--config_webserver_port)
* [`config_secret_key`](#-superset--config_secret_key)
* [`config_sqlalchemy_database_uri`](#-superset--config_sqlalchemy_database_uri)
* [`config_wtf_csrf_enabled`](#-superset--config_wtf_csrf_enabled)
* [`config_wtf_csrf_exempt_list`](#-superset--config_wtf_csrf_exempt_list)
* [`config_wtf_csrf_time_limit`](#-superset--config_wtf_csrf_time_limit)
* [`config_mapbox_api_key`](#-superset--config_mapbox_api_key)
* [`pgsql_database`](#-superset--pgsql_database)
* [`pgsql_user`](#-superset--pgsql_user)
* [`pgsql_password`](#-superset--pgsql_password)
* [`pgsql_host`](#-superset--pgsql_host)
* [`pgsql_port`](#-superset--pgsql_port)
* [`python_version`](#-superset--python_version)
* [`python_pip`](#-superset--python_pip)
* [`python_dev`](#-superset--python_dev)
* [`python_venv`](#-superset--python_venv)
* [`db_drivers`](#-superset--db_drivers)

##### <a name="-superset--install_dir"></a>`install_dir`

Data type: `String`

The directory that a Python Virtual Environment will be created under and where Superset will be installed

Default value: `'/home/superset'`

##### <a name="-superset--version"></a>`version`

Data type: `Variant[Enum['present','absent','latest'], String[1]]`

The version of Apache Superset to install.

Default value: `'2.1.0'`

##### <a name="-superset--additional_python_lib"></a>`additional_python_lib`

Data type: `Array[String]`

Array of additional python libraries to install.

Default value: `[]`

##### <a name="-superset--port"></a>`port`

Data type: `Integer`

The port that that superset will be served from. Default: 8088

Default value: `8088`

##### <a name="-superset--user"></a>`user`

Data type: `String`

The owner of any file/folders created for the Superset installation

Default value: `'superset'`

##### <a name="-superset--load_examples"></a>`load_examples`

Data type: `Boolean`

Option for loading example charts and data.  Default: false

Default value: `false`

##### <a name="-superset--manage_python"></a>`manage_python`

Data type: `Boolean`

Option for managing the installation of python.  Default: true

Default value: `true`

##### <a name="-superset--manage_webserver"></a>`manage_webserver`

Data type: `Boolean`

Option for managing a gunicorn webserver.  Default: true

Default value: `true`

##### <a name="-superset--manage_db"></a>`manage_db`

Data type: `Boolean`

Option for managing a Postgresql db back-end.  Default: true

Default value: `true`

##### <a name="-superset--manage_firewall"></a>`manage_firewall`

Data type: `Boolean`

Option for managing firewall (RHEL8 firwalld).  Default: false

Default value: `false`

##### <a name="-superset--admin_username"></a>`admin_username`

Data type: `String`

Parameter for setting the admin user username

Default value: `'admin'`

##### <a name="-superset--admin_password"></a>`admin_password`

Data type: `Sensitive[String]`

Sensitive parameter for setting the admin user password

Default value: `Sensitive('password')`

##### <a name="-superset--admin_firstname"></a>`admin_firstname`

Data type: `String`

Parameter for setting the admin user first name

Default value: `'admin'`

##### <a name="-superset--admin_lastname"></a>`admin_lastname`

Data type: `String`

Parameter for setting the admin user last name

Default value: `'admin'`

##### <a name="-superset--admin_email"></a>`admin_email`

Data type: `String`

Parameter for setting the admin user email address

Default value: `'admin@mycompany.com'`

##### <a name="-superset--gunicorn_install_dir"></a>`gunicorn_install_dir`

Data type: `String`

Overide for gunicorn install_dir option.

Default value: `'/home/superset'`

##### <a name="-superset--gunicorn_workers"></a>`gunicorn_workers`

Data type: `Integer`

Overide for gunicorn workers option.

Default value: `10`

##### <a name="-superset--gunicorn_worker_class"></a>`gunicorn_worker_class`

Data type: `Enum['sync','eventlet','gevent','tornado']`

Overide for gunicorn worker_class option.

Default value: `'gevent'`

##### <a name="-superset--gunicorn_timeout"></a>`gunicorn_timeout`

Data type: `Integer`

Overide for gunicorn timeout option.

Default value: `120`

##### <a name="-superset--gunicorn_bind"></a>`gunicorn_bind`

Data type: `String`

Overide for gunicorn bind option.

Default value: `'0.0.0.0:8088'`

##### <a name="-superset--gunicorn_limit_request_line"></a>`gunicorn_limit_request_line`

Data type: `Integer`

Overide for gunicorn limit_request_line option.

Default value: `0`

##### <a name="-superset--gunicorn_limit_request_field_size"></a>`gunicorn_limit_request_field_size`

Data type: `Integer`

Overide for gunicorn limit_request_field_size option.

Default value: `0`

##### <a name="-superset--gunicorn_statsd_host"></a>`gunicorn_statsd_host`

Data type: `String`

Overide for gunicorn statsd_host option.

Default value: `'localhost:8125'`

##### <a name="-superset--manage_config"></a>`manage_config`

Data type: `Boolean`

Boolean for setting whether to manage the config file superset_config.py

Default value: `true`

##### <a name="-superset--config_row_limit"></a>`config_row_limit`

Data type: `Optional[Integer]`

Optional setting for setting ROW_LIMIT in superset_config.py

Default value: `undef`

##### <a name="-superset--config_webserver_port"></a>`config_webserver_port`

Data type: `Optional[Integer]`

Optional setting for setting SUPERSET_WEBSERVER_PORT in superset_config.py

Default value: `undef`

##### <a name="-superset--config_secret_key"></a>`config_secret_key`

Data type: `Sensitive[String]`

Sensitive parameter for setting SECRET_KEY in superset_config.py

Default value: `Sensitive('53cR37K3y')`

##### <a name="-superset--config_sqlalchemy_database_uri"></a>`config_sqlalchemy_database_uri`

Data type: `Optional[String]`

Optional setting for setting SQLALCHEMY_DATABASE_URI in superset_config.py

Default value: `undef`

##### <a name="-superset--config_wtf_csrf_enabled"></a>`config_wtf_csrf_enabled`

Data type: `Optional[Boolean]`

Optional setting for setting WTF_CSRF_ENABLED in superset_config.py

Default value: `undef`

##### <a name="-superset--config_wtf_csrf_exempt_list"></a>`config_wtf_csrf_exempt_list`

Data type: `Optional[Array[String]]`

Optional setting for setting WTF_CSRF_EXEMPT_LIST in superset_config.py

Default value: `undef`

##### <a name="-superset--config_wtf_csrf_time_limit"></a>`config_wtf_csrf_time_limit`

Data type: `Optional[Integer]`

Optional setting for setting WTF_CSRF_TIME_LIMIT in superset_config.py

Default value: `undef`

##### <a name="-superset--config_mapbox_api_key"></a>`config_mapbox_api_key`

Data type: `Optional[String]`

Optional setting for setting MAPBOX_API_KEY in superset_config.py

Default value: `undef`

##### <a name="-superset--pgsql_database"></a>`pgsql_database`

Data type: `String`

Overide option for overiding the default postgresql database

Default value: `'superset'`

##### <a name="-superset--pgsql_user"></a>`pgsql_user`

Data type: `String`

Overide option for overiding the default postgresql user

Default value: `'superset'`

##### <a name="-superset--pgsql_password"></a>`pgsql_password`

Data type: `Sensitive[String]`

Overide option for overiding the default postgresql password

Default value: `Sensitive('password')`

##### <a name="-superset--pgsql_host"></a>`pgsql_host`

Data type: `String`

Overide option for overiding the default postgresql host

Default value: `'localhost'`

##### <a name="-superset--pgsql_port"></a>`pgsql_port`

Data type: `Integer`

Overide option for overiding the default postgresql port

Default value: `5432`

##### <a name="-superset--python_version"></a>`python_version`

Data type: `String`

Overide option for setting the Python version if it will be managed by this module

Default value: `'python39'`

##### <a name="-superset--python_pip"></a>`python_pip`

Data type: `Enum['present','absent','latest']`

Parameter for setting whether the ensure python-pip is present, absent or latest

Default value: `'present'`

##### <a name="-superset--python_dev"></a>`python_dev`

Data type: `Enum['present','absent','latest']`

Parameter for setting whether the ensure python-dev is present, absent or latest

Default value: `'present'`

##### <a name="-superset--python_venv"></a>`python_venv`

Data type: `Enum['present','absent','latest']`

Parameter for setting whether the ensure python-venv is present, absent or latest

Default value: `'absent'`

##### <a name="-superset--db_drivers"></a>`db_drivers`

Data type: `Array[String]`

Overide option for setting database drivers (python database driver packages) to be installed

Default value: `['psycopg2']`

## Tasks

### <a name="delete_superset_venv"></a>`delete_superset_venv`

A task for deleting the Apache Superset virtual environment directory

**Supports noop?** false

