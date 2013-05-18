# == Class: nfs
#
# Manages NFS client/server
#
class nfs {
  $packages = [ 'nfs-utils', 'rpcbind' ]
  $services = [ 'rpcbind', 'nfslock', 'nfs' ]

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
