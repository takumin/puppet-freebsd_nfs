# == Class freebsd_nfs::service
#
# This class is meant to be called from freebsd_nfs.
# It ensure the service is running.
#
class freebsd_nfs::service {
  Service {
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  if $::freebsd_nfs::server_enable and $::freebsd_nfs::client_enable {
    if $::freebsd_nfs::use_nfsv4 {
      service { 'hostid':
        ensure     => stopped,
        enable     => false,
        hasstatus  => false,
        hasrestart => false,
      } ->
      service { 'rpcbind': } ->
      service { 'nfsclient': } ->
      service { 'nfsuserd': } ->
      service { 'mountd': } ->
      service { 'nfsd': } ->
      service { 'statd': } ->
      service { 'lockd': } ->
      service { 'nfscbd': }
    } else {
      service { 'rpcbind': } ->
      service { 'nfsclient': } ->
      service { 'mountd': } ->
      service { 'nfsd': } ->
      service { 'statd': } ->
      service { 'lockd': } ->
      service { 'nfscbd': }
    }
  } elsif $::freebsd_nfs::server_enable {
    if $::freebsd_nfs::use_nfsv4 {
      service { 'rpcbind': } ->
      service { 'nfsuserd': } ->
      service { 'mountd': } ->
      service { 'nfsd': } ->
      service { 'statd': } ->
      service { 'lockd': }
    } else {
      service { 'rpcbind': } ->
      service { 'mountd': } ->
      service { 'nfsd': } ->
      service { 'statd': } ->
      service { 'lockd': }
    }
  } elsif $::freebsd_nfs::client_enable {
    if $::freebsd_nfs::use_nfsv4 {
      service { 'hostid':
        ensure     => stopped,
        enable     => false,
        hasstatus  => false,
        hasrestart => false,
      } ->
      service { 'rpcbind': } ->
      service { 'nfsclient': } ->
      service { 'nfsuserd': } ->
      service { 'statd': } ->
      service { 'lockd': } ->
      service { 'nfscbd': }
    } else {
      service { 'rpcbind': } ->
      service { 'nfsclient': } ->
      service { 'statd': } ->
      service { 'lockd': } ->
      service { 'nfscbd': }
    }
  }
}
