define yumcache::package ( 
  $target,
  $deps = 'true', 
){

  if ! ($deps in ['true','false'] ) {
    fail("yumcache::package::${name}: \$deps not a string of true|false - you gave ${deps}")
  }
  if $deps == 'true' {
    $resolvedeps = '--resolve'
  }

  exec { "yumdownload_${name}_${target}":
    command => "yumdownloader ${name} --destdir=${::yumcache_basedir}/${target} ${resolvedeps}",
    creates => "${::yumcache_basedir}/${target}/$name",
    path    => '/usr/bin:/bin:/usr/local/bin',
  }
  file { "${::yumcache_basedir}/${target}/$name":
    ensure => file,
    require => Exec["yumdownload_${name}_${target}"],
    notify  => Exec["createrepo_${target}"],
  }

}
