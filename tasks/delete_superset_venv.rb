#! /opt/puppetlabs/puppet/bin/ruby
# A task for deleting the Apache Superset virtual environment directory
require 'facter'
require 'fireutils'

superset_install_dir = Facter.value('superset_installdir')

if Dir.exists? (superset_install_dir)
  FileUtils.rm_rf(superset_install_dir, :secure=>true)
  puts "Apache Superset virtual environment directory '#{superset_install_dir}' deleted successfully!"
  exit 0
else
  puts "Apache Superset virtual environment directory '#{e.message}' does not exist"
  exit 1
end
