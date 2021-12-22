# frozen_string_literal: true

install_dir = Facter.value(:superset_installdir)
if File.exist?("#{install_dir}/superset_config.py")
  Facter.add(:superset_config) do
    confine kernel: 'Linux'
    setcode do
      config = {}
      install_dir = Facter.value(:superset_installdir)

      config_file = File.open("#{install_dir}/superset_config.py", 'r')

      config_file.each_line do |line|
        # Skip comments and empty lines
        next if line.start_with?('#') || line.empty?
        next unless line.include? ' = '
        data = line.split(' = ')
        if data[0] == 'SQLALCHEMY_DATABASE_URI'
          config['SUPERSET_DATABASE'] = {}
          config['SUPERSET_DATABASE']['TYPE'] = data[1].chomp.match(%r{((?<=').+(?=://))})[0]
          config['SUPERSET_DATABASE']['HOSTNAME'] = data[1].chomp.match(%r{((?<=@).+(?=:\d+|:\d/))})[0]
          config['SUPERSET_DATABASE']['PORT'] = data[1].chomp.match(%r{((?<=:)\d+(?=/))})[0]
          config['SUPERSET_DATABASE']['DB_NAME'] = data[1].chomp.match(%r{((?<=\d/).+$)})[0]
        else
          config[data[0]] = data[1].chomp
        end
      end
      config
    end
  end
end
