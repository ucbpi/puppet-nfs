# == Class: nfs::services
#
# Enables the NFS services required for client or server operations
#
class nfs::services {
  service { $nfs::services: ensure => running }
}
