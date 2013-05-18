# == Class: nfs::install
#
# Installs the required packages for our NFS client
#
class nfs::install {
  # install our packages
  package { $nfs::params::packages:
    ensure => installed,
  }
}
