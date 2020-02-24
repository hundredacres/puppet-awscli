# == Class: awscli::params
#
# This class manages awscli parameters depending on the platform and
# should *not* be called directly.
#
class awscli::params {
  $manage_deps = false
  $proxy = undef
  $install_options = undef

  case $::os['family'] {
    'Debian': {
      $pkg_dev = 'python-dev'
      $pkg_pip = 'python-pip'
    }
    'RedHat': {
      if $::os['name'] == 'Amazon' {
        $pkg_dev = 'python27-devel'
      } else {
        $pkg_dev = 'python-devel'
      }

      case $::os['release']['major'] {
        '7': {
          $pkg_pip = 'python2-pip'
        }
        default: {
          $pkg_pip = 'python-pip'
        }
      }
    }
    'Darwin': {
      $pkg_dev = 'python'
      $pkg_pip = 'brew-pip'
    }
    default:  { fail("The awscli module does not support ${::os['family']}") }
  }
}
