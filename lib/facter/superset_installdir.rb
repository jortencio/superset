# frozen_string_literal: true

Facter.add(:superset_installdir) do
  confine kernel: 'Linux'
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    path = Facter::Core::Execution.execute('echo $SUPERSET_CONFIG_PATH')
    path.sub('/superset_config.py', '')
  end
end
