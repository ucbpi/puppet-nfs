# == Class: nfs
#
# Manages NFS client/server
#
class nfs {
  $packages = [ 'nfs-utils', 'rpcbind' ]

  # we'll leave nfslock out of here, since it doesn't handle the right
  # return codes.  we may need to revisit later and fix.
  $services = [ 'rpcbind', 'nfs' ]

  # define where we should default to creating our export directories

  # what's the primary config file for this module?
  # in the case of nfs, it's /etc/exports
  $config = '/etc/exports'

  $order = {
    'header' => '00',
    'export' => '01',
    'start'  => '01',
    'client' => '02',
    'end'    => '03',
  }
}
