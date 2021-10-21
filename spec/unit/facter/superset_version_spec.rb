# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/superset_version'

describe :superset_version, type: :fact do
  subject(:fact) { Facter.fact(:superset_version) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to eq('hello facter')
  end
end
