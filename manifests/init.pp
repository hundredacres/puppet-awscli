# == Class: awscli
#
# Install awscli
#
# === Parameters
#
#  [$version]
#    Provides ability to change the version of awscli being installed.
#    Default: 'present'
#    This variable is required.
#
#  [$manage_deps]
#    Handles installing package deps.
#    Default: false
#
#  [$pkg_dev]
#    Provides ability to install a specific Dev package by name.
#    Default: See awscli::params Class
#    This variable is optional.
#
#  [$pkg_pip]
#    Provides ability to install a specific PIP package by name.
#    Default: See awscli::params Class
#    This variable is optional.
#
# === Examples
#
#  class { awscli: }
#
# === Authors
#
# Justin Downing <justin@downing.us>
#
# === Copyright
#
# Copyright 2014 Justin Downing
#
class awscli (
  $version     = 'present',
  $manage_deps = $awcli::params::manage_deps,
  $pkg_dev     = $awscli::params::pkg_dev,
  $pkg_pip     = $awscli::params::pkg_pip
) inherits awscli::params {
  $real_deps = $manage_deps ? {
    true  => "Class['awscli::deps']",
    false => undef,
  }
  if $manage_deps {
    include awscli::deps
  }
  package { 'awscli':
    ensure   => $version,
    provider => 'pip',
    require  => $real_deps,
  }
}
