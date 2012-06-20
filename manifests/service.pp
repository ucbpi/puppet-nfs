class nfs::service {
  service { $nfs::params::service:
    ensure => stopped,
  }
}
