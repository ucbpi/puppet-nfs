# == Class: nfs::export::reload
#
# Handy class that can be notified to trigger exportfs to reload the exports
# file
#
class nfs::export::reload {
  exec { 'exportfs -r':
    command     => '/usr/sbin/exportfs -r',
    refreshonly => true,
  }
}
