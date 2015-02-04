require 'facter/util/file_read'
require 'puppet'
require 'puppet/util/fileparsing'

module Facter::NameService
  class Parser
    include Puppet::Util::FileParsing

    def initialize()
      text_line :comment, :match => /^\s*#/
      text_line :blank, :match => /^\s*$/

      record_line :nsswitch,
        :fields => %w{name lookup},
        :joiner => ":\t",
        :separator => /\s*:\s*/
    end
  end

  def self.add_facts

    if FileTest.exists?('/etc/nsswitch.conf')
      parser = Facter::NameService::Parser.new
      records = parser.parse(Facter::Util::FileRead.read('/etc/nsswitch.conf'))

      records.each do |record|
        if record[:record_type] == :nsswitch
          lookup = record[:lookup].split.join(',')
          Facter.add("name_service_#{record[:name]}") do
            setcode { lookup }
          end
        end
      end
    else
      Facter.debug('No /etc/nsswitch.conf')
    end

  end
end
Facter::NameService.add_facts
