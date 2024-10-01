# superset

A Puppet module that is used for installing and configuring Apache Superset which is a data exploration and visualization platform.

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

This Puppet module is used to do basic installation and configuration of Apache Superset.

## Setup

### What superset affects

Superset module installs and configures the following:

* Superset dependencies
* Python (Optional)
* Creates a Python virtual environment and installs dependent Python Libraries (including superset) within it
* Configures Firewalld on RHEL (Optional)
* Installs and configures a basic Postgresql Database as a Superset Back-end (Optional)
* Manages a Gunicorn web server for hosting superset (Optional)

Any of the services marked as (Optional) above can be managed seperately by setting the relevant parameters to false (See reference)

### Setup Requirements

In order to use this module, make sure to have the following Puppet modules installed:

* puppetlabs-stdlib
* puppet-python
* puppet-epel
* puppetlabs-yumrepo_core
* puppet-firewalld
* puppetlabs-augeas_core
* puppetlabs-postgresql
* puppetlabs-apt
* puppetlabs-concat

### Beginning with superset

In order to get started with the superset Puppet module with a basic configuration (Basic Install of Apache Superset with Python, Gunicorn, Postgresql installed/configured)

```puppet
include superset
```

## Usage

This module supports the use of Hiera data for setting parameters.  Please refer to REFERENCE.md for a list of configurable parameters

### Common Usage

#### Setup Superset with a configured admin user

```puppet
class { 'superset':
    admin_username  => '<username>',
    admin_password  => '<password>',
    admin_firstname => '<firstname>',
    admin_lastname  => '<password>',
    admin_email     => '<email>',
}
```

#### Setup Superset to manage firewalld on RedHat Linux

```puppet
class { 'superset':
  manage_firewall => true,
}
```

#### Change default database in Superset config file (superset_config.py)

```puppet
class { 'superset':
  manage_db                      => false,
  config_sqlalchemy_database_uri => <Database URI>,
}
```

Note: To see a list of supported databases and format for sqlalchemy_database_uri, please see: [Installing Database URI][2]

Note 2: When installing on another database, please also configure the superset::db_drivers to include additional database drivers.  By default, the postgresql driver will already be included in this list.

#### Setting sensitive data

To set sensitive data such as admin the postgresql DB password, use the Sensitive in a class declaration.  e.g.:

```puppet
class { 'superset':
  pgsql_password => Sensitive('<password>'),
}
```

Alternatively, use `lookup_options` in hiera.  e.g.:

```yaml
---
lookup_options:
  superset::pgsql_password:
    convert_to: "Sensitive"

superset::pgsql_password: '<password>'
```

#### Setting a gunicorn worker class:

In class declaration:

```puppet
class { 'superset':
  gunicorn_worker_class => 'tornado',
}
```

In Hiera:

```yaml
---
superset::gunicorn_worker_class: "tornado"
```

## Limitations

The Superset module has a number of limitations:

* It has only been tested to work on RedHat 8, RedHat9, Ubuntu 20.04, Ubuntu 22.04
* Superset app configuration file limited to options currently specified in the epp template
* It is currently only to install the current latest version of the python Superset library.  As at this release it is version 4.0.2 (Except for Ubuntu 20.04 install which installs 2.1.3 by default)
* The admin parameters are limited in that any previously configured admin users will remain in Superset's DB and will need to be removed manually within the Superset
  * i.e. Log in as a user with the Admin role, click on *Settings* and under *Security* click on *List User*.  Here you can see the previous admin user and delete the entry

## Development

If you would like to contribute with the development of this module, please feel free to log development changes in the [issues][3] register for this project or submit a Pull Request.

[1]: https://superset.apache.org/
[2]: https://superset.apache.org/docs/databases/installing-database-drivers
[3]: https://github.com/jortencio/superset/issues
