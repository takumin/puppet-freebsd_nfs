# == Class freebsd_nfs::params
#
# This class is meant to be called from freebsd_nfs.
# It sets variables according to platform.
#
class freebsd_nfs::params {
  case $::osfamily {
    'FreeBSD': {
      $server_enable              = false
      $client_enable              = false
      $use_nfsv4                  = false
      $package_name               = [ 'sysutils/libsunacl' ]
      $server_config              = '/etc/exports'
      $export                     = undef
      $export_nfsv4               = {
        'root'     => '/',
        'sec'      => undef,
        'network'  => undef,
        'netmask'  => undef,
        'netgroup' => undef,
      }
      $rpcbind_flags              = undef
      $rpc_lockd_flags            = undef
      $rpc_statd_flags            = undef
      $mountd_flags               = undef
      $weak_mountd_authentication = undef
      $nfsuserd_flags             = undef
      $nfs_server_flags           = undef
      $nfs_reserved_port_only     = undef
      $oldnfs_server_enable       = undef
      $nfsv4_server_enable        = undef
      $nfsclient_flags            = undef
      $nfs_access_cache           = undef
      $nfs_bufpackets             = undef
      $nfscbd_flags               = undef
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
