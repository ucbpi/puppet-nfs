# == Define: nfs::export::config
#
# Sets up our NFS exports file, and handles reloading of the exports file
# whenever changes are made
#
class nfs::export::config {
  include concat::setup
  include nfs
  include nfs::export::reload
  include nfs::services

  $config = $nfs::config
  validate_absolute_path( $config )

  concat { $config:
    owner  => root,
    group  => root,
    mode   => '0444',
    notify => Class['nfs::export::reload'],
  }

  $head_frag_order_arr = [ $nfs::order[header], 'header' ]
  $head_frag_order = join( $head_frag_order_arr, '_' )
  concat::fragment { 'nfs_config_header':
      target  => $config,
      content => "# Managed by Puppet\n\n",
      order   => $head_frag_order,
  }
}
