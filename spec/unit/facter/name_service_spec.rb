require 'spec_helper'
require 'facter/util/file_read'

RSpec.configure do |config|
  config.before(:each) do
    Facter.clear
    Facter.clear_messages
    Facter::Util::Loader.any_instance.stubs(:load_all)

    # Adapted from puppetlabs-stdlib/spec/unit/facter/pe_version_spec.rb
    if Facter.collection.respond_to? :load     # Facter 2.x
      Facter.collection.load(:name_service)
    else                                       # Facter 1.x
      Facter.collection.loader.load(:name_service)
    end

    Facter::Util::FileRead.stubs(:read).with('/etc/nsswitch.conf') \
      .returns(File.read(fixtures('static/nsswitch.conf')))

    FileTest.stubs(:exists?).with('/etc/nsswitch.conf').returns(true)

    Facter::NameService.add_facts
  end
end

describe 'Facter::NameService.add_facts' do

    it 'should return a multivalued lookup' do
      expect(Facter.fact(:name_service_passwd).value).to eq('selif,ldap')
    end

    it 'should return a multivalued lookup with weird chars' do
      expect(Facter.fact(:name_service_bootparams).value).to \
        eq('nisplus,[NOTFOUND=return],selif')
    end

    it 'should return a simple single-valued lookup' do
      expect(Facter.fact(:name_service_automount).value).to eq('selif')
    end

end
