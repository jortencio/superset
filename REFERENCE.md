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

* [`install_dir`](#install_dir)
* [`port`](#port)
* [`user`](#user)
* [`load_examples`](#load_examples)
* [`manage_python`](#manage_python)
* [`manage_webserver`](#manage_webserver)
* [`manage_db`](#manage_db)
* [`manage_firewall`](#manage_firewall)
* [`admin_config`](#admin_config)
* [`gunicorn_config`](#gunicorn_config)
* [`app_config`](#app_config)
* [`pgsql_config`](#pgsql_config)
* [`python_version`](#python_version)
* [`db_drivers`](#db_drivers)

##### <a name="install_dir"></a>`install_dir`

Data type: `String`

The directory that a Python Virtual Environment will be created under and where Superset will be installed

##### <a name="port"></a>`port`

Data type: `Integer`

The port that that superset will be served from. Default: 8088

##### <a name="user"></a>`user`

Data type: `String`

The owner of any file/folders created for the Superset installation

##### <a name="load_examples"></a>`load_examples`

Data type: `Boolean`

Option for loading example charts and data.  Default: false

##### <a name="manage_python"></a>`manage_python`

Data type: `Boolean`

Option for managing the installation of python.  Default: true

##### <a name="manage_webserver"></a>`manage_webserver`

Data type: `Boolean`

Option for managing a gunicorn webserver.  Default: true

##### <a name="manage_db"></a>`manage_db`

Data type: `Boolean`

Option for managing a Postgresql db back-end.  Default: true

##### <a name="manage_firewall"></a>`manage_firewall`

Data type: `Boolean`

Option for managing firewall (RHEL8 firwalld).  Default: false

##### <a name="admin_config"></a>`admin_config`

Data type: `Hash`

Overide option for superset admin user data (username, first name, last name, email, password).
Default:
- username: admin
- password: password

##### <a name="gunicorn_config"></a>`gunicorn_config`

Data type: `Hash`

Overide option for gunicorn.
Default:
- install_dir: "%{lookup('superset::install_dir')}"
- workers: 10
- timeout: 120
- bind: "0.0.0.0:%{lookup('superset::port')}"
- limit_request_line: 0
- limit_request_field_size: 0
- statsd_host: localhost:8125

##### <a name="app_config"></a>`app_config`

Data type: `Hash`

Overide option for overiding the superset default configuration
Available options include:
- row_limit
- superset_webserver_port
- secret_key
- sqlalchemy_database_uri
- wtf_csrf_enabled
- wtf_csrf_exempt_list
- wtf_csrf_time_limit
- mapbox_api_key

##### <a name="pgsql_config"></a>`pgsql_config`

Data type: `Hash`

Overide option for overiding the default postgresql configuration
Available options include:
- database
- user
- password
- host
- port

##### <a name="python_version"></a>`python_version`

Data type: `String`

Overide option for setting the Python version if it will be managed by this module

##### <a name="db_drivers"></a>`db_drivers`

Data type: `Array[String]`

Overide option for setting database drivers (python database driver packages) to be installed

