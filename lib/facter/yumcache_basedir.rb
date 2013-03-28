Facter.add("yumcache_basedir") do
    setcode do
        File.join(Puppet[:vardir],"yumcache")
    end
end
