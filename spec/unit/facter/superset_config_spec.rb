# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/superset_config'

describe :superset_config, type: :fact do
  subject(:fact) { Facter.fact(:superset_config) }

  let(:content) { StringIO.new("#\nkey1 = value1\n\n#\nkey2 = value2\n") }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
    allow(Facter.fact(:kernel)).to receive(:value).and_return('Linux')
    allow(Facter).to receive(:value).with(:superset_installdir).and_return('/home/superset/apache-superset')
    allow(File).to receive(:open).with('/home/superset/apache-superset/superset_config.py', 'r').and_return(content)
  end

  it 'returns a value' do
    expect(fact.value).to eq({ 'key1' => 'value1', 'key2' => 'value2' })
  end
end
