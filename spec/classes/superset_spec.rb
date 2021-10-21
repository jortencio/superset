# frozen_string_literal: true

require 'spec_helper'

describe 'superset' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
      it { is_expected.to contain_class('superset::packages') }
      it { is_expected.to contain_class('superset::python') }
      it { is_expected.to contain_class('superset::install') }
      it { is_expected.to contain_class('superset::config') }
      it { is_expected.to contain_class('superset::postgresql') }
      it { is_expected.to contain_class('superset::init_db') }
      it { is_expected.to contain_class('superset::service') }

      #ToDo add conditional test for firewalld

    end
  end
end
