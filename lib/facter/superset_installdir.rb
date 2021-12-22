# frozen_string_literal: true

Facter.add(:superset_installdir) do
  confine kernel: 'Linux'
  setcode do
    Facter::Core::Execution.execute('/bin/bash -c "env"')
    # path.sub('/superset_config.py', '')
  end
end
