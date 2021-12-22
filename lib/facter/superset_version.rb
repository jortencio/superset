# frozen_string_literal: true

install_dir = Facter.value(:superset_installdir)
unless install_dir.nil?
  Facter.add(:superset_version) do
    confine kernel: 'Linux'
    setcode do
      Facter::Core::Execution.execute("#{install_dir}/bin/superset version | grep Superset | sed -r \"s/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g\"",
      { on_fail: 'Superset Version Not Found' })
    end
  end
end
