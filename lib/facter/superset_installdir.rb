# frozen_string_literal: true

Facter.add(:superset_installdir) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    Facter::Core::Execution.execute('echo $SUPERSET_CONFIG_PATH')
  end
end
