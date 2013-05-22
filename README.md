
name_service
============
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



Parameters
----------

- **ensure**
    The basic property that the resource should be in.  Valid values are
    `present`, `absent`.

- **lookup**
    The list of service specifications and reactions to be used for lookup.

- **name**
    The name of the system database ('passwd', 'group', etc.)

- **target**
    The name of the file which stores the name service configuration.

Providers
---------

- **nsswitch**
    Sun-style `nsswitch.conf`, as used in Solaris and Linux.
