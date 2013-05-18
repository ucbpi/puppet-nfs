# == Class: nfs::services::disable
#
# Disables the NFS services from running. Useful for locking down a system to
# only necesary services
#
class nfs::services::disable {
  services { $nfs::params::service: ensure => stopped }
}
