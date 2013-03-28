# == Define: yumcache
#
# Full description of class yumcache here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { yumcache:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
define yumcache (
  $url = "http://${::fqdn}/${title}",
  $repo_enabled = 1,
){

  include yumcache::setup

  $basedir = "${::yumcache_basedir}/${name}"

  file { "${basedir}":
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  file { "${basedir}/repodata":
    ensure => directory,
  }
  file { "${basedir}/repodata/filelists.xml.gz":
    ensure  => file,
    replace => false,
  }
  file { "${basedir}/repodata/other.xml.gz":
    ensure  => file,
    replace => false,
  }
  file { "${basedir}/repodata/repomd.xml":
    ensure  => file,
    replace => false,
  }
  file { "${basedir}/repodata/primary.xml.gz":
    ensure  => file,
    replace => false,
  }

  exec { "createrepo_${name}":
    command     => "createrepo ${basedir}",
    path        => '/bin:/usr/bin',
    refreshonly => true,
  }

  @@yumrepo{ "yumcache_${name}":
    enabled => $repo_enabled,
    baseurl => $url,
    name    => "yumcache_${name}",
    tag     => ['yumcache',"${::operatingsystem}${::operatingsystemrelease}"],
  }

}
