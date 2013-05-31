# NFS Management Module #

This module manages NFS exports and client configuration focused currently on
NFSv4 + Kerberos on RHEL6.  RHEL5 support should be fairly trivial if it doesn't
already work, but I have not tested it out yet.

## Dependencies ##

* ripienaar-concat >= 0.2.0
* puppetlabs-stdlib >= 2.6.0

# State #

This module will support more features as I get around to needing them, though
pull requests are encouraged and accepted.  In particular, anything that builds
out a more robust support for NFS on RHEL, or adds support for Debian will be a
high priority for review.

Currently, the exports *should* work, but the code hasn't been used in some time
so if there are any issues please submit an issue and I will fix ASAP.

The client configuration is used however, and is currently capable of
configuring the NFS side of NFSv4 + Kerberos.

## Example ##

<pre><code>
  # Add some NFS exports
  nfs::export { '/export/sysadmins': }

  # Add some clients
  nfs::export::client { 'allow sysadmins rw to /export/acctvol':
    export => '/export/sysadmins',
    options => 'rw',
    source => '10.0.2.0/24',
  }

  # We don't really need to create our export seperately though,
  # the client class is smart enough to do it for us
  nfs::export::client { 'allow accting rw to /export/acctvol':
    export => '/export/acctvol',
    options => 'rw,no_root_squash',
    source => '10.1.2.0/24',
  }

  nfs::export::client { 'allow sysadmins ro to /export/acctvol':
    export => '/export/acctvol',
    options => 'ro',
    source => '10.0.2.0/24',
  }
</code></pre>

License
-------

None

Contact
-------

Aaron Russo <arusso@berkeley.edu>

Support
-------

Please log tickets and issues at the
[Projects site](https://github.com/arusso23/puppet-nfs/issues/)
