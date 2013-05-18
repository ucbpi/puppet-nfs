# == Class: nfs::exportfs::reload
#
# Handy class that can be notified to trigger exportfs to reload the exports
# file
#
class nfs::exportfs::reload {
  exec { 'exportfs -r':
    command     => '/usr/sbin/exportfs -r',
    refreshonly => true,
  }
}
