# superset

A Puppet module that is used for isntalling and configuring Apache Superset which is a data exploration and visualization platform.

For more information, please visit [Apache Superset][1].

## Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with superset](#setup)
    * [What superset affects](#what-superset-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with superset](#beginning-with-superset)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This Puppet module is used to do basic installation and configuration of Apache Superset on RedHat systems.

## Setup

### What superset affects

Superset module installs and configures the following:

* Superset dependencies
* Python 3.8 (Optional)
* Creates a Python virtual environment and installs dependent Python Libraries (including superset) within it
* Configures Firewalld on RHEL (Optional)
* Installs and configures a basic Postgresql Database as a Superset Back-end (Optional)

Any of the services marked as (Optional) above can be managed seperately by setting the relevant parameters to false (See reference)

### Setup Requirements 

In order to use this module, make sure to have the following Puppet modules installed:

* puppetlabs-stdlib
* puppet-python
* puppet-epel
* puppetlabs-yumrepo_core
* puppet-firewalld
* puppetlabs-augeas_core"
* puppetlabs-postgresql
* puppetlabs-apt
* puppetlabs-concat

### Beginning with superset

In order to get started with superset module with a basic configuration (Basic Install of Apache Superset with Python and Postgresql Installed)

```
include superset
```

## Usage

This module supports the use of Hiera data for setting parameters.  The following is a list of parameters configurable in Hiera (Please refer to REFERENCE.md for more details):

```
---
superset::install_dir: 
superset::port: 
superset::manage_python: 
superset::manage_firewall: 
superset::manage_webserver: 
superset::manage_db: 
superset::load_examples: 
superset::user: 
superset::python_version: 
superset::manage_webserver: 

superset::admin_config:
  username: 
  password: 
  firstname: 
  lastname: 
  email: 

superset::gunicorn_config:
  install_dir: 
  workers: 
  timeout: 
  bind: 
  limit_request_line: 
  limit_request_field_size: 
  statsd_host: 

superset::pgsql_config:
  database:
  user:
  password:
  host:
  port:

superset::app_config:
  superset_webserver_port: 
  sqlalchemy_database_uri: 

superset::db_drivers:
  - 
```

Common Usage:

Setup Superset with a configured admin user:

```
class { 'superset':
  admin_config => {
    username  => '<username>'
    password  => '<password>'
    firstname => '<firstname>'
    lastname  => '<password>'
    email     => '<email>'
  }
}
```

Setup Superset to manage firewalld on RedHat Linux:

```
class { 'superset':
  manage_firewall => true
}
```

Change default Superset config file (superset_config.py):

```
class { 'superset':
  
  app_config => {
    superset_webserver_port => <webserver_port>
    sqlalchemy_database_uri => <Database URI>
  }
}
```
Note: by setting up the app_config parameter in this way you will be overwriting the default app_config completely.  

If you would like to only configure one of the many configuration options and leave others as per the default, this can be done using hiera data and the **lookup()** function

In Hieradata data:

```
superset::appconfig:
  sqlalchemy_database_uri: 'sqlite:////path/to/superset.db'
  
```

```
class { 'superset':
  app_config => lookup('superset::appconfig', merge => hash)
}
```

Note to see a list of supported databases and format for sqlalchemy_database_uri, please see: [Installing Database URI][2]

Note 2: When installing on another database, please also configure the superset::db_drivers to include additional database drivers.  By default, the postgresql driver will already be included in this list.

## Limitations

The Superset module has a number of limitations:
* It has only been tested to work on RedHat 8
* Though the Python version can be overwritten, Superset module has only been tested on Python 3.9
* It currently only installs the current latest version of the python Superset library
* The admin_config parameter is limited in that any previously configured admin users will remain in Superset's DB and will need to be removed manually within the Superset 
  * i.e. Logged in as a user with the Admin role, click on *Settings* and under *Security* click on *List User*.  Here you can see the older user and delete them)

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][3] register for this project  


[1]: https://superset.apache.org/
[2]: https://superset.apache.org/docs/databases/installing-database-drivers
[3]: https://github.com/jortencio/superset/issues
