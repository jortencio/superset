# frozen_string_literal: true

Facter.add(:superset_version) do
  confine kernel: 'Linux'
  setcode do
    '/home/superset/apache-superset/bin/superset version | grep Superset'
  end
end
