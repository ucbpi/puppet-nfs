# == Class: nfs
#
# Manages NFS client/server
#
class nfs {
  # ensure we install the needed packages
  include nfs::install

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
