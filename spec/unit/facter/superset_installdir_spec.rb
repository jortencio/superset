# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/superset_installdir'

describe :superset_installdir, type: :fact do
  subject(:fact) { Facter.fact(:superset_installdir) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
    allow(Facter::Core::Execution).to receive(:execute).with('/usr/bin/echo test').and_return('/opt/apache-superset/superset_config.py')
  end

  it 'returns a value' do
    expect(fact.value).to eq('/opt/apache-superset/superset_config.py')
  end
end
