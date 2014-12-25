# == define freebsd_nfs::export
#
# This define is called from freebsd_nfs for nfs export.
#
define freebsd_nfs::export (
  $maproot  = undef,
  $mapall   = undef,
  $alldirs  = undef,
  $sec      = undef,
  $ro       = undef,
  $public   = undef,
  $webnfs   = undef,
  $index    = undef,
  $quiet    = undef,
  $network  = undef,
  $netmask  = undef,
  $netgroup = undef,
) {
  if $maproot {
    $_maproot = "-maproot=$maproot"
  } else {
    $_maproot = ''
  }
  if $mapall {
    $_mapall = "-mapall"
  } else {
    $_mapall = ''
  }
  if $alldirs {
    $_alldirs = "-alldirs"
  } else {
    $_alldirs = ''
  }
  if $sec {
    $_sec_list = join($sec, ':')
    $_sec = "-sec $_sec_list"
  } else {
    $_sec = ''
  }
  if $ro {
    $_ro = "-ro"
  } else {
    $_ro = ''
  }
  if $public {
    $_public = "-public"
  } else {
    $_public = ''
  }
  if $webnfs {
    $_webnfs = "-webnfs"
  } else {
    $_webnfs = ''
  }
  if $index {
    $_index = "-index=$index"
  } else {
    $_index = ''
  }
  if $quiet {
    $_quiet = "-quiet"
  } else {
    $_quiet = ''
  }
  if $network {
    $_network = "-network $network"
  } else {
    $_network = ''
  }
  if $netmask {
    $_netmask = "-mask $netmask"
  } else {
    $_netmask = ''
  }
  if $netgroup {
    $_netgroup_list = join($netgroup, ' ')
    $_netgroup = "$_netgroup_list"
  } else {
    $_netgroup = ''
  }

  $args = "$_maproot $_mapall $_alldirs $_sec $_ro $_public $_webnfs $_index $_quiet $_network $_netmask $_netgroup"

  concat::fragment { "nfs_export[$name]":
    target  => $::freebsd_nfs::server_config,
    content => "$name $args",
  }
}
