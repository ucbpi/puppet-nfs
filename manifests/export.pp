# == Define: nfs::export
#
# Defines an NFS export
#
define nfs::export {
  include nfs
  include nfs::config

  $config = $nfs::config

  validate_absolute_path( $name )
  $export_r = $name
  $export_filesafe_r = regsubst( $name, '\/', '_' , 'G' )


  # define the start of the line
  $start_frag_order_arr = [ $nfs::order[export], $export_filesafe_r,
                            $nfs::order[start] ]
  $start_frag_order = join( $start_frag_order_arr, '_' )
  concat::fragment { "nfs-export-${export_filesafe_r}-start":
    target  => $config,
    content => "${export_r} \\\n",
    order   => $start_frag_order,
  }

  # define a blank line to break out of the trailing \ we've been leaving
  # define the end of the line
  $end_frag_order_arr = [ $nfs::order[export], $export_filesafe_r,
                          $nfs::order[end] ]
  $end_frag_order = join( $end_frag_order_arr, '_' )
  concat::fragment { "nfs-export-${export_filesafe_r}-end":
    target  => $config,
    content => "\n",
    order   => $end_frag_order,
  }
}
