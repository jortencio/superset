# frozen_string_literal: true

Facter.add(:superset_version) do
  # confine :kernel => "Linux"
  # https://puppet.com/docs/puppet/latest/fact_overview.html

  setcode do
    superset_version = Facter::Core::Execution.execute('/home/superset/apache-superset/bin/superset version | grep Superset', { :on_fail => 'Superset Version Not Found' } )
    superset_version.split(' ')[1]
  end
end
