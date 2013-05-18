# == Class: nfs::service
#
# Enables the NFS service
#
class nfs::service {
  include nfs::params

  service { $nfs::params::service: ensure => running }
}
