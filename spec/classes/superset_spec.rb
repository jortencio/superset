# frozen_string_literal: true

require 'spec_helper'

describe 'superset', :class do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'With default values (no parameters set)' do
        it { is_expected.to compile }

        it { is_expected.to contain_class('superset::packages') }

        if os_facts[:operatingsystem] == 'RedHat' # Need to find out how to check for opersatingsystemrelease
          packages = ['gcc', 'gcc-c++', 'libffi-devel', 'cyrus-sasl-devel', 'openssl-devel', 'openldap-devel', 'postgresql-devel']
        end

        packages.each do |package|
          it { is_expected.to contain_package(package).with_ensure('installed') }
        end

        it { is_expected.to contain_class('superset::python') }

        it { is_expected.to contain_class('superset::install') }
        it { is_expected.to contain_user('superset') }
        it { is_expected.to contain_group('superset') }
        it { is_expected.to contain_file('/etc/profile.d/superset.sh') }
        it { is_expected.to contain_Python__Pyvenv('/home/superset/apache-superset') }
        it { is_expected.to contain_Python__Pip('apache-superset') }
        it { is_expected.to contain_Python__Pip('gevent') }
        it { is_expected.to contain_Python__Pip('gunicorn') }
        it { is_expected.to contain_Python__Pip('psycopg2') }

        it { is_expected.to contain_class('superset::config') }

        it { is_expected.to contain_class('superset::postgresql') }
        it { is_expected.to contain_Postgresql__Server__Db('superset') }

        it { is_expected.to contain_class('superset::init_db') }
        it { is_expected.to contain_exec('Create Admin User') }
        it { is_expected.to contain_exec('Initialize DB') }
        it { is_expected.to contain_exec('Initialize default roles and permissions') }

        it { is_expected.to contain_class('superset::service') }
        it { is_expected.to contain_file('/bin/superset.gunicorn') }
        it { is_expected.to contain_file('/usr/lib/systemd/system/superset.service') }
        it { is_expected.to contain_service('superset') }

        it { is_expected.to contain_file('/home/superset/apache-superset/superset_config.py') }
      end

      context 'With manage_python set to true and the admin_config set' do
        let(:params) do
          { 'manage_python': true, admin_config: {
            username: 'test_admin',
          password: 'test_password',
          firstname: 'test_admin',
          lastname: 'test_admin_password',
          email: 'test-admin@mycompany.com'
          } }
        end

        it { is_expected.to compile }

        it { is_expected.to contain_class('superset::packages') }

        if os_facts[:operatingsystem] == 'RedHat' # Need to find out how to check for opersatingsystemrelease
          packages = ['gcc', 'gcc-c++', 'libffi-devel', 'cyrus-sasl-devel', 'openssl-devel', 'openldap-devel', 'postgresql-devel']
        end

        packages.each do |package|
          it { is_expected.to contain_package(package).with_ensure('installed') }
        end

        it { is_expected.to contain_class('superset::python') }

        it { is_expected.to contain_class('superset::install') }
        it { is_expected.to contain_user('superset') }
        it { is_expected.to contain_group('superset') }
        it { is_expected.to contain_file('/etc/profile.d/superset.sh') }
        it { is_expected.to contain_Python__Pyvenv('/home/superset/apache-superset') }
        it { is_expected.to contain_Python__Pip('apache-superset') }
        it { is_expected.to contain_Python__Pip('gevent') }
        it { is_expected.to contain_Python__Pip('gunicorn') }
        it { is_expected.to contain_Python__Pip('psycopg2') }

        it { is_expected.to contain_class('superset::config') }

        it { is_expected.to contain_class('superset::postgresql') }
        it { is_expected.to contain_Postgresql__Server__Db('superset') }

        it { is_expected.to contain_class('superset::init_db') }
        it { is_expected.to contain_exec('Create Admin User') }
        it { is_expected.to contain_exec('Initialize DB') }
        it { is_expected.to contain_exec('Initialize default roles and permissions') }

        it { is_expected.to contain_class('superset::service') }
        it { is_expected.to contain_file('/bin/superset.gunicorn') }
        it { is_expected.to contain_file('/usr/lib/systemd/system/superset.service') }
        it { is_expected.to contain_service('superset') }

        it { is_expected.to contain_file('/home/superset/apache-superset/superset_config.py') }

        it { is_expected.to contain_class('Python') }

        if os_facts[:operatingsystem] == 'RedHat'
          it { is_expected.to contain_package('python3-wheel') }

        end
      end

      context 'With manage_python set to true and the admin_config set' do
        let(:params) do
          { 'manage_firewall': true, admin_config: {
            username: 'test_admin',
          password: 'test_password',
          firstname: 'test_admin',
          lastname: 'test_admin_password',
          email: 'test-admin@mycompany.com'
          } }
        end

        it { is_expected.to compile }

        it { is_expected.to contain_class('superset::packages') }

        if os_facts[:operatingsystem] == 'RedHat' # Need to find out how to check for opersatingsystemrelease
          packages = ['gcc', 'gcc-c++', 'libffi-devel', 'cyrus-sasl-devel', 'openssl-devel', 'openldap-devel', 'postgresql-devel']
        end

        packages.each do |package|
          it { is_expected.to contain_package(package).with_ensure('installed') }
        end

        it { is_expected.to contain_class('superset::python') }

        it { is_expected.to contain_class('superset::install') }
        it { is_expected.to contain_user('superset') }
        it { is_expected.to contain_group('superset') }
        it { is_expected.to contain_file('/etc/profile.d/superset.sh') }
        it { is_expected.to contain_Python__Pyvenv('/home/superset/apache-superset') }
        it { is_expected.to contain_Python__Pip('apache-superset') }
        it { is_expected.to contain_Python__Pip('gevent') }
        it { is_expected.to contain_Python__Pip('gunicorn') }
        it { is_expected.to contain_Python__Pip('psycopg2') }

        it { is_expected.to contain_class('superset::config') }

        it { is_expected.to contain_class('superset::postgresql') }
        it { is_expected.to contain_Postgresql__Server__Db('superset') }

        it { is_expected.to contain_class('superset::init_db') }
        it { is_expected.to contain_exec('Create Admin User') }
        it { is_expected.to contain_exec('Initialize DB') }
        it { is_expected.to contain_exec('Initialize default roles and permissions') }

        it { is_expected.to contain_class('superset::service') }
        it { is_expected.to contain_file('/bin/superset.gunicorn') }
        it { is_expected.to contain_file('/usr/lib/systemd/system/superset.service') }
        it { is_expected.to contain_service('superset') }

        it { is_expected.to contain_file('/home/superset/apache-superset/superset_config.py') }

        it { is_expected.to contain_class('superset::firewalld') }
        it { is_expected.to contain_Firewalld_port('Open the port used for superset: 8088') }
      end
    end
  end
end
