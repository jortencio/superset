# frozen_string_literal: true

Facter.add(:superset_installdir) do
  confine kernel: 'Linux'
  setcode do
    Facter::Core::Execution.execute('echo $SUPERSET_CONFIG_PATH')
    # path.sub('/superset_config.py', '')
  end
end
