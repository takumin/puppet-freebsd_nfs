# == Class freebsd_nfs::config
#
# This class is called from freebsd_nfs for service config.
#
class freebsd_nfs::config {
  if $::freebsd_nfs::server_enable or $::freebsd_nfs::client_enable {
    concat { $::freebsd_nfs::server_config:
      ensure => present,
    }
    if $::freebsd_nfs::use_nfsv4 {
      if $::freebsd_nfs::export_nfsv4['sec'] {
        $sec = "-sec join(${::freebsd_nfs::export_nfsv4['sec']}, ':')"
      } else {
        $sec = ''
      }
      if $::freebsd_nfs::export_nfsv4['network'] {
        $network = "-network ${::freebsd_nfs::export_nfsv4['network']}"
      } else {
        $network = ''
      }
      if $::freebsd_nfs::export_nfsv4['netmask'] {
        $netmask = "-mask ${::freebsd_nfs::export_nfsv4['netmask']}"
      } else {
        $netmask = ''
      }
      if $::freebsd_nfs::export_nfsv4['netgroup'] {
        $netgroup = join($::freebsd_nfs::export_nfsv4['netgroup'], ' ')
      } else {
        $netgroup = ''
      }

      $args = "${sec} ${network} ${netmask} ${netgroup}"

      concat::fragment { 'export_nfsv4':
        target  => $::freebsd_nfs::server_config,
        content => "V4:${::freebsd_nfs::export_nfsv4['root']} $args",
        order   => '01'
      }
    }

    if $::freebsd_nfs::mountd_flags != '' {
      sysrc { 'rpcbind_flags':
        value => "$::freebsd_nfs::rpcbind_flags",
        path  => '/etc/rc.conf.d/rpcbind',
      }
    }

    if $::freebsd_nfs::rpc_lockd_flags != '' {
      sysrc { 'rpc_lockd_flags':
        value => "$::freebsd_nfs::rpc_lockd_flags",
        path  => '/etc/rc.conf.d/lockd',
      }
    }

    if $::freebsd_nfs::rpc_statd_flags != '' {
      sysrc { 'rpc_statd_flags':
        value => "$::freebsd_nfs::rpc_statd_flags",
        path  => '/etc/rc.conf.d/statd',
      }
    }

    if $::freebsd_nfs::use_nfsv4 {
      if $::freebsd_nfs::nfsuserd_flags != '' {
        if $::freebsd_nfs::nfsuserd_flags !~ /-domain/ {
          $nfsuserd_flags = "${::freebsd_nfs::nfsuserd_flags} -domain ${::domain}"
        } else {
          $nfsuserd_flags = $::freebsd_nfs::nfsuserd_flags
        }
      } else {
          $nfsuserd_flags = "-domain ${::domain}"
      }

      sysrc { 'nfsuserd_flags':
        value => "$nfsuserd_flags",
        path  => '/etc/rc.conf.d/nfsuserd',
      }
    }
  }

  if $::freebsd_nfs::server_enable {
    if $::freebsd_nfs::mountd_flags != '' {
      sysrc { 'mountd_flags':
        value => "$::freebsd_nfs::mountd_flags",
        path  => '/etc/rc.conf.d/mountd',
      }
    }

    if $::freebsd_nfs::weak_mountd_authentication {
      sysrc { 'weak_mountd_authentication':
        value => 'YES',
        path  => '/etc/rc.conf.d/mountd',
      }
    }

    if $::freebsd_nfs::nfs_server_flags != '' {
      sysrc { 'nfs_server_flags':
        value => "$::freebsd_nfs::nfs_server_flags",
        path  => '/etc/rc.conf.d/nfsd',
      }
    }

    if $::freebsd_nfs::nfs_reserved_port_only != '' {
      sysrc { 'nfs_reserved_port_only':
        value => 'YES',
        path  => '/etc/rc.conf.d/nfsd',
      }
    }

    if $::freebsd_nfs::oldnfs_server_enable != '' {
      sysrc { 'oldnfs_server_enable':
        value => 'YES',
        path  => '/etc/rc.conf.d/nfsd',
      }
    }

    if $::freebsd_nfs::use_nfsv4 {
      sysrc { 'nfsv4_server_enable':
        value => 'YES',
        path  => '/etc/rc.conf.d/nfsd',
      }
    } else {
      if $::freebsd_nfs::nfsv4_server_enable {
        sysrc { 'nfsv4_server_enable':
          value => 'YES',
          path  => '/etc/rc.conf.d/nfsd',
        }
      }
    }
  }

  if $::freebsd_nfs::client_enable {
    if $::freebsd_nfs::nfsclient_flags {
      sysrc { 'nfsclient_flags':
        value => "$::freebsd_nfs::nfsclient_flags",
        path  => '/etc/rc.conf.d/nfsclient',
      }
    }

    if $::freebsd_nfs::nfs_access_cache {
      sysrc { 'nfs_access_cache':
        value => "$::freebsd_nfs::nfs_access_cache",
        path  => '/etc/rc.conf.d/nfsclient',
      }
    }

    if $::freebsd_nfs::nfs_bufpackets {
      sysrc { 'nfs_bufpackets':
        value => "$::freebsd_nfs::nfs_bufpackets",
        path  => '/etc/rc.conf.d/nfsclient',
      }
    }

    if $::freebsd_nfs::nfscbd_flags {
      sysrc { 'nfscbd_flags':
        value => "$::freebsd_nfs::nfscbd_flags",
        path  => '/etc/rc.conf.d/nfscbd',
      }
    }
  }
}
