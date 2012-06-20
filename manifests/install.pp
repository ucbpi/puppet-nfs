class nfs::install
{
  # install our packages
  package { $nfs::params::packages:
    ensure => installed,
  }
}
