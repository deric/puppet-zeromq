# == Class: zeromq
#
# Will install ZeroMQ library
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
# [*version*]
#   Version which will be installed, you should fetch this file from official
#   website, e.g.: http://download.zeromq.org/zeromq-3.2.2.tar.gz 
#
#
# === Examples
#
#  class { zeromq:
#    version => '3.2.2'
#  }
#
# === Authors
#
# Tomas Barton <barton.tomas@gmail.com>
#
# === Copyright
#
# Copyright 2013 Tomas Barton.
#

class zeromq (
  $version = $zeromq::params::version,
  $libpath = $zeromq::params::libpath,
) inherits zeromq::params {


#  require build::install
  $target_name =  "zeromq"
  $tarball = "${target_name}-${version}.tar.gz"
  $download = "http://download.zeromq.org/${tarball}"
  $tmp_dir = "/tmp"
# using ruby code in puppet:
#  $filename = inline_template("<%= File.basename(download) %>")

  build::requires { "zeromq-requires-uuid-dev":  package => 'uuid-dev' }
  build::requires { "zeromq-requires-libtool":  package => 'libtool' }
  build::requires { "zeromq-requires-autoconf":  package => 'autoconf' }
  build::requires { "zeromq-requires-automake":  package => 'automake' }


  build::install { 'zeromq':
    url      => "http://download.zeromq.org/${tarball}",
    creates  => "${libpath}/libzmq.so",
    extracted_dir   => "${target_name}-${version}",
    notify   => Exec["ldconfig"],
  }


  
  exec { "ldconfig":
    command => "ldconfig",
  }
}
