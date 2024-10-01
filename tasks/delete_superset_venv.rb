#! /opt/puppetlabs/puppet/bin/ruby
# A task for deleting the Apache Superset virtual environment directory
require 'facter'

superset_install_dir = Facter.value('superset_installdir')

begin
  Dir.rmdir(superset_install_dir)
  puts "Apache Superset virtual environment directory '#{superset_install_dir}' deleted successfully!"
rescue SystemCallError => e
  puts "Apache Superset virtual environment directory deletion failed: #{e.message}"
end
