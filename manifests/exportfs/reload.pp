class nfs::exportfs::reload {
  exec { 'exportfs -r':
    command     => '/usr/sbin/exportfs -r',
    refreshonly => true,
  }
}
