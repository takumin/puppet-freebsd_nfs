# == Class: freebsd_nfs
#
# Full description of class freebsd_nfs here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class freebsd_nfs (
  $server_enable              = $::freebsd_nfs::params::server_enable,
  $client_enable              = $::freebsd_nfs::params::client_enable,
  $use_nfsv4                  = $::freebsd_nfs::params::use_nfsv4,
  $package_name               = $::freebsd_nfs::params::package_name,
  $server_config              = $::freebsd_nfs::params::server_config,
  $export_nfsv4               = $::freebsd_nfs::params::export_nfsv4,
  $rpcbind_flags              = $::freebsd_nfs::params::rpcbind_flags,
  $rpc_lockd_flags            = $::freebsd_nfs::params::rpc_lockd_flags,
  $rpc_statd_flags            = $::freebsd_nfs::params::rpc_statd_flags,
  $mountd_flags               = $::freebsd_nfs::params::mountd_flags,
  $weak_mountd_authentication = $::freebsd_nfs::params::weak_mountd_authentication,
  $nfsuserd_flags             = $::freebsd_nfs::params::nfsuserd_flags,
  $nfs_server_flags           = $::freebsd_nfs::params::nfs_server_flags,
  $nfs_reserved_port_only     = $::freebsd_nfs::params::nfs_reserved_port_only,
  $oldnfs_server_enable       = $::freebsd_nfs::params::oldnfs_server_enable,
  $nfsv4_server_enable        = $::freebsd_nfs::params::nfsv4_server_enable,
  $nfsclient_flags            = $::freebsd_nfs::params::nfsclient_flags,
  $nfs_access_cache           = $::freebsd_nfs::params::nfs_access_cache,
  $nfs_bufpackets             = $::freebsd_nfs::params::nfs_bufpackets,
  $nfscbd_flags               = $::freebsd_nfs::params::nfscbd_flags,
) inherits ::freebsd_nfs::params {

  # validate parameters here

  class { '::freebsd_nfs::install': } ->
  class { '::freebsd_nfs::config': } ~>
  class { '::freebsd_nfs::service': } ->
  Class['::freebsd_nfs']
}
