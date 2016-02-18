# == Class: awscli::deps::redhat
#
# This module manages awscli dependencies for redhat $::osfamily.
#
class awscli::deps::redhat {
  include yum::repo::epel
  Package { require => Class['yum::repo::epel'] }
  ensure_packages(['python-devel','python-pip'])
}
