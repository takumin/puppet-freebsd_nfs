require 'spec_helper'

describe 'freebsd_nfs' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "freebsd_nfs class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('freebsd_nfs::params') }
        it { should contain_class('freebsd_nfs::install').that_comes_before('freebsd_nfs::config') }
        it { should contain_class('freebsd_nfs::config') }
        it { should contain_class('freebsd_nfs::service').that_subscribes_to('freebsd_nfs::config') }

        it { should contain_service('freebsd_nfs') }
        it { should contain_package('freebsd_nfs').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'freebsd_nfs class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('freebsd_nfs') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
