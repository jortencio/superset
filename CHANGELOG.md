# Changelog

All notable changes to this project will be documented in this file.

## Release 1.0.0
**Features**
* Added Ubuntu 20.04 support [#17](https://github.com/jortencio/superset/pull/17)
* Added support for setting different gunicorn working classes [#21](https://github.com/jortencio/superset/pull/21)
* Flattened hash type parameters into seperate parameters for ease of setting parameters [#20](https://github.com/jortencio/superset/pull/20)
* Updated Superset parameters to secure passwords and secret keys with sensitive type (e.g. [#15](https://github.com/jortencio/superset/pull/15))
* Added parameter `additional_python_lib` to help manage issues with problematic python libraries. (e.g. [#14](https://github.com/jortencio/superset/pull/14))
* Added performance improvements to initial installation.  Thank you Gigko! [#13](https://github.com/jortencio/superset/pull/13)
* General cleanup of manifests to align with Puppet style guide
* Update module dependency minimum requirements.  See dependencies for details.
* Update PDK template to v3.0.0

**Bugfixes**
* Fix issues caused by newer versions of sqlparse and marshmellow-enum python libraries [#14](https://github.com/jortencio/superset/pull/14)

**Known Issues**
* Doesn't delete previous admin user when the admin user is updated in hiera
* Gunicorn worker classes `gevent` and `eventlet` currently not working due to `select.epoll()` issues.  Recommend using `tornado` or `sync` worker class for this version.

## Release 0.1.1
**Bugfixes**
* Fixed issue "broken superset install - cannot import name 'soft_unicode' from 'markupsafe'" [#8](https://github.com/jortencio/superset/issues/8)

**Known Issues**
* Doesn't delete previous admin user when the admin user is updated in hiera

## Release 0.1.0

**Features**
* Initial Release - Basic Installation of Apache Superset

**Known Issues**
* Doesn't delete previous admin user when the admin user is updated in hiera
