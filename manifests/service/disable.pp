# == Class: nfs::service::disable
#
# Disables the NFS services from running. Useful for locking down a system to
# only necessary services
#
class nfs::service::disable {
  service { $nfs::params::service: ensure => stopped }
}
