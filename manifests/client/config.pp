# == Class: nfs::client::config
#
# Configures the NFS client on a host
#
class nfs::client::config(
  $rpcgssdargs = undef,
  $secure_nfs = undef,
  $nfsv4 = undef,
  $idmapd_domain = undef,
  $idmapd_verbosity = undef
) {
  include nfs

  $config = '/etc/sysconfig/nfs'

  Ini_setting {
    ensure  => present,
    path    => $config,
    section => '',
  }

  # SECURE_NFS Setting
  if $secure_nfs != undef {
    $secure_content = any2bool( $secure_nfs ) ? {
      true    => 'yes',
      false   => 'no',
      default => 'no',
    }

    ini_setting { "${config}:SECURE_NFS":
      setting => 'SECURE_NFS',
      value   => $secure_content,
    }
  }

  if $rpcgssdargs != undef {
    validate_string( $rpcgssdargs )
    ini_setting { "${config}:RPCGSSDARGS":
      setting => 'RPCGSSDARGS',
      value   => $rpcgssdargs,
    }
  }

  # This should probably be broken out into a GSSAPI module, but for now,
  # it lives here.
  file { '/etc/gssapi_mech.conf':
    ensure => present,
    mode   => '0444',
    owner  => 'root',
    group  => 'root',
  }

  if any2bool( $nfsv4 ) {
    # at least on rhel6, this isn't need as it is included by default,
    # but no harm in putting it in here anyways, right?
    file_line { 'gssapi_mech.conf:libgssapi_krb5':
      ensure  => present,
      line    => "libgssapi_krb5.so.2\t\tmechglue_internal_krb5_init",
      path    => '/etc/gssapi_mech.conf',
      require => File['/etc/gssapi_mech.conf'],
    }

    ini_setting { 'idmapd.conf:domain':
      section => 'General',
      path    => '/etc/idmapd.conf',
      setting => 'Domain',
      value   => $idmapd_domain,
    }

    if $idmapd_verbosity != undef {
      ini_setting { 'idmapd.conf:verbosity':
        section => 'General',
        path    => '/etc/idmapd.conf',
        setting => 'Verbosity',
        value   => $idmapd_verbosity,
      }
    }
  }
}
