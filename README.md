This module uses existing configured Yum repos to download specific packages (and optionally satisfy
dependencies) and then create a local repo from the result.

Requires storeconfigs to export the Yumrepo, and you need to add the vhost config for yourself

    yumcache { 'my_yumcache': }
    yumcache::package { 'httpd':
      target => 'my_yumcache',
    }
    yumcache::package { 'haproxy':
      target => 'my_yumcache',
      deps   => 'false',
    }
    Yumrepo <<| tag == 'yumcache' |>>

Example Apache config:

    Alias /my_yumcache "/var/opt/lib/pe-puppet/yumcache/my_yumcache"
    <Directory /var/opt/lib/pe-puppet/yumcache/my_yumcache>
        AllowOverride None
        Order allow,deny
        Allow from all
    </Directory>
