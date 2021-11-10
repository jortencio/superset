# frozen_string_literal: true

Facter.add(:superset_version) do
  confine kernel: 'Linux'
  # https://puppet.com/docs/puppet/latest/fact_overview.html

  setcode do
    install_dir = Facter.value(:superset_installdir)
    superset_version = Facter::Core::Execution.execute("#{install_dir}/bin/superset version | grep Superset | sed -r \"s/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\"",
{ on_fail: 'Superset Version Not Found' })
    superset_version.split(' ')[1]
  end
end
