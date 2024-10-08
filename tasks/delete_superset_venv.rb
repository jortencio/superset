#! /opt/puppetlabs/puppet/bin/ruby
# A task for deleting the Apache Superset virtual environment directory
require 'facter'
require 'fileutils'

superset_install_dir = Facter.value('superset_installdir')

if Dir.exist?(superset_install_dir)
  FileUtils.rm_rf(superset_install_dir, secure: true)
  puts "Apache Superset virtual environment directory '#{superset_install_dir}' deleted successfully!"
  exit 0
else
  STDERR.puts 'Apache Superset virtual environment directory does not exist!'
  exit 1
end
