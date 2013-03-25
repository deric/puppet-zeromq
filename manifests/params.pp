class zeromq::params {
  case $::osfamily {
    debian, ubuntu: {
      $version = "3.2.2"
      $libpath = "/usr/local/lib"
    }
    default: {
      case $::osfamily {
        default: {
          fail("Unsupported platform: ${::osfamily}/${::operatingsystem}")
        }
      }
    }
  }
}
