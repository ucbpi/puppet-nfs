import 'concat'

class nfs::config {
  include concat::setup

  # create our concat file target
  concat { $nfs::params::config_file:
    owner => root,
    group => root,
    mode  => 444,
    notify => Service['nfs'],
  }

  # create our header fragment
  concat::fragment { "nfs-export-header":
    target  => $nfs::params::config_file,
    content => template("nfs/header.erb"),
    order   => "${nfs::params::conf_header_priority}",
  }
}

define nfs::export_entry (
  export,            # name of the export to associate this with
  client,            # what client/subnet should this apply to?
  rw = false,         # by default, we'll assume ro
  sync = true,       # by default, lets perform synchronous writes
  no_wdelay = false, # by default, lets not disable write_delay
  root_squash = true, # by default, requests with uid/gid 0 are mapped to anon
  all_squash = false # by default, we wont squash all users
)
{
  $clean_export = regsubst($export, "\/", "_", "G")
  
  concat::fragment {
    "${nfs::params::conf_export_entry_priority}_client_${client}":
      target => $nfs::params::config_file,
      content => template("nfs/export-entry.erb"),
      order => "${nfs::params::conf_export_priority}_export_${clean_export}",
  }
}

define nfs::export ( )
{
  $clean_export = regsubst($title, "/", "_", "G")

  # define the start of the line
  concat::fragment {
    "${nfs::params::conf_start_priority}_start":
      target => $nfs::params::config_file,
      content => template("nfs/export-start.erb"),
      order => "${nfs::params::conf_export_priority}_export_${clean_export}",
  }  

  # define the end of the line
  concat::fragment {
    "${nfs::params::conf_end_priority}_end":
      target => $nfs::params::config_file,
      content => template("nfs/export-end.erb"),
      order => "${nfs::params::conf_export_priority}_export_${clean_export}"
  }
}    
