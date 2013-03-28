class yumcache::setup {

  if ! $::yumcache_basedir {
    fail("yumcache::setup: no yumcache_basedir fact defined")
  }
  file { $::yumcache_basedir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }
  package { 'yum-utils':
    ensure => present,
  }
  package { 'createrepo':
    ensure => present,
  }

}
