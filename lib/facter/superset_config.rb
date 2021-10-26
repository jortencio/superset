# frozen_string_literal: true

Facter.add(:superset_config) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    config = {}
    install_dir = Facter.value(:superset_installdir)

    config_file = File.open("#{install_dir}/superset_config.py", "r")

    config_file.each_line do |line|
      if line.start_with? '#' || line.empty?
        next
      elsif line.include? ' = '
        data = line.split(' = ')
        config[data[0]] = data[1].chomp 
      end
    end
    config
  end
end
