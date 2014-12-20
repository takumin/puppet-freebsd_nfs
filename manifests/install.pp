# == Class freebsd_nfs::install
#
# This class is called from freebsd_nfs for install.
#
class freebsd_nfs::install {
  if $::freebsd_nfs::use_nfsv4 {
    package { $::freebsd_nfs::package_name:
      ensure => present,
    }
  }
}
