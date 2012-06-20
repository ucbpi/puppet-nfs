class nfs::params {
  # define the package we require
  $packages = [ "nfs-utils", "rpcbind" ]
  $service = [ "rpcbind", "nfslock", "nfs" ]
  
  # define where we should default to creating our export directories

  # what's the primary config file for this module?
  # in the case of nfs, it's /etc/exports
  $config_file = "/etc/exports"

  $conf_header_priority = "00"
  $conf_export_priority = "01"
  
  # secondary priority
  $conf_start_priority = "01"
  $conf_export_entry_priority = "10"
  $conf_end_priority = "99"
}
