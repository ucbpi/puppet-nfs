# == Class: nfs::client::config
#
# Configures the NFS client on a host
#
class nfs::client::config(
  $rpcgssdargs = undef,
  $secure_nfs = undef
) {
  $config = '/etc/sysconfig/nfs'

  Ini_setting {
    ensure  => present,
    path    => $config,
    section => '',
  }

  # SECURE_NFS Setting
  if ! $secure_nfs == undef {
    $secure_content = any2bool( $secure_nfs ) ? {
      true    => 'yes',
      false   => 'no',
      default => 'no',
    }

    ini_setting { 'secure_nfs setting':
      setting => 'SECURE_NFS',
      value   => $secure_content,
    }
  }

  if ! $rpcgssdargs == undef {
    validate_string( $rpcgssdargs )
    ini_setting { 'NFS - RPCGSSDARGS Setting':
      setting => 'RPCGSSDARGS',
      value   => $rpcgssdargs,
    }
  }
}
