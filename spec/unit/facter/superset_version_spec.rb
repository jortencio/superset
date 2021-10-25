# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/superset_version'

describe :superset_version, type: :fact do
  subject(:fact) { Facter.fact(:superset_version) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
    allow(Facter).to receive(:value).with(:superset_installdir).and_return('/home/superset/apache-superset')
    allow(Facter::Core::Execution).to receive(:execute).with('/home/superset/apache-superset/bin/superset version | grep Superset | sed -r "s/\\x1B\\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"',
{ on_fail: 'Superset Version Not Found' }).and_return('Superset 1.3.2')
  end

  it 'returns a value' do
    expect(fact.value).to eq('1.3.2')
  end
end
