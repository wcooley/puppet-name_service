#
# Copyright (C)2013 Will R. (Wil) Cooley
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

require 'puppet'
require 'puppet/property/ordered_list'

Puppet::Type.newtype(:name_service) do
  desc <<-EOT
    Manages name service configuration for system databases such as
    passwd, group, etc. which on Linux and Solaris systems is in
    `/etc/nsswitch.conf`.

    Example:
        name_service { ['passwd', 'group', 'shadow', 'netgroup']:
          lookup => ['files', 'ldap']
        }
        name_service { 'hosts':
          lookup => [ 'files', 'mdns4_minimal', '[NOTFOUND=return]', 'dns', ],
        }
        name_service { ['protocols', 'services', 'rpc', 'networks', 'ethers']:
          lookup => 'files'
        }
  EOT
  ensurable

  newparam(:name, :namevar => true) do
    desc "The name of the system database ('passwd', 'group', etc.)"
  end

  newproperty(:lookup, :parent => Puppet::Property::OrderedList) do
    desc "The list of service specifications and reactions to be used for lookup."

    def delimiter
      " "
    end
    def inclusive?
      true
    end
  end

  newproperty(:target) do
    desc "The name of the file which stores the name service configuration."

    defaultto {
      if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
        @resource.class.defaultprovider.default_target
      else
        nil
      end
    }
  end

  autorequire(:file) do
    self[:target]
  end
end
