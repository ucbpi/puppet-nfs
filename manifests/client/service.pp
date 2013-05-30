class nfs::client::service {
  include nfs

  service { 'rpcbind':
    ensure  => running,
    enable  => true,
    require => Class['nfs::install'],
  }

  service { 'nfslock':
    ensure  => running,
    enable  => true,
    require =>  [ Service['rpcbind'], Class['nfs::install'] ],
    status  => '/sbin/service nfslock status',
  }

  if $nfs::client::config::secure {
    service { 'rpcgssd':
      ensure  => running,
      enable  => true,
      require => Class['nfs::client::config'],
    }

    service { 'rpcidmapd':
      ensure  => running,
      enable  => true,
      require => Class['nfs::client::config'],
    }
  }
}
