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

require 'puppet/provider/parsedfile'

Puppet::Type.type(:name_service).provide(
    :nsswitch,
    :parent => Puppet::Provider::ParsedFile,
    :default_target => '/etc/nsswitch.conf',
    :filetype => :flat
) do
  desc "Sun-style `nsswitch.conf`, as used in Solaris and Linux."

  text_line :comment, :match => /^\s*#/
  text_line :blank, :match => /^\s*$/

  record_line :nsswitch,
    :fields => %w{name lookup},
    :joiner => ":\t",
    :separator => /\s*:\s*/
end
