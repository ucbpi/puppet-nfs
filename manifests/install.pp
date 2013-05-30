# == Class: nfs::install
#
# Installs the required packages for our NFS client
#
class nfs::install {
  # install our packages
  $packages = [ 'nfs-utils', 'rpcbind' ]
  package { $packages:
    ensure => installed,
  }
}
