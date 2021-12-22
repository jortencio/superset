# frozen_string_literal: true

Facter.add(:superset_installdir) do
  confine kernel: 'Linux'
  setcode do
    Facter::Core::Execution.execute('echo $USER')
    # path.sub('/superset_config.py', '')
  end
end
