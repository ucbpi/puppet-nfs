# == Define: nfs::export::client
#
# Defines a single export
#
# === Parameters:
#
# [*export*]
#
# The name of the export to associate this client entry with
#
# [*options*]
#
# The option strings for this client
#
# [*source*]
#
# The source ip/hostname/network/etc.
#
define nfs::export::client (
  $export = undef,
  $options = undef,
  $source = undef
) {
  include nfs
  $config = $nfs::config

  if ! defined( Nfs::Export[$export] ) { nfs::export { $export: } }

  $export_r = $export
  $export_filesafe_r = regsubst( $export, '\/', '_', 'G' )
  $source_r = $source
  $source_filesafe_r = regsubst( $source_r, '\/', '_', 'G' )
  $options_r = $options


  $client_export_order_arr = [ $nfs::order[export], $export_filesafe_r,
                                $nfs::order[client], $source_filesafe_r ]
  $client_export_order = join( $client_export_order_arr, '_' )
  concat::fragment { "nfs_export_${source_r}_${export_filesafe_r}":
    target  => $config,
    content => "    ${source_r}(${options_r}) \\\n",
    order   => $client_export_order,
  }
}
