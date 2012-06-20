class nfs::service {
  service { $nfs::params::service:
    ensure => running,
  }
}
