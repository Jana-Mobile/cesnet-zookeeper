# == Class zookeeper::install
#
# Installs zookeeper node.
#
class zookeeper::install {
  include ::stdlib

  if $zookeeper::zookeeper_package_version != undef {
      package {'zookeeper':
        ensure => $zookeeper::zookeeper_package_version,
        before => Package[$zookeeper::packages]
      }
  }

  ensure_packages($zookeeper::packages)

  ::hadoop_lib::postinstall{ 'zookeeper':
    alternatives => $::zookeeper::alternatives,
  }
  Package[$zookeeper::packages] -> ::Hadoop_lib::Postinstall['zookeeper']
}
