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
#  [$manage_epel]
#    Boolean flag to install the EPEL repositories.
#    Default: true
#    This variable is optional.
#
#  [$install_pkgdeps]
#    Boolean flag to install the package dependencies or not
#    Default: true
#
#  [$install_pip]
#    Boolean flag to install pip or not
#    Default: true
#
#  [$proxy]
#    String proxy variable for use with EPEL module
#    Default: undef
#
#  [$install_options]
#    Array of install options for the awscli Pip package
#    Default: undef
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
  $version          = 'present',
  $manage_deps = $awscli::params::manage_deps,
  $pkg_dev          = $awscli::params::pkg_dev,
  $pkg_pip          = $awscli::params::pkg_pip,
  $manage_epel      = true,
  $install_pkgdeps  = true,
  $install_pip      = true,
  $proxy            = $awscli::params::proxy,
  $install_options  = $awscli::params::install_options,
) inherits awscli::params {
  $real_deps = $awscli::manage_deps ? {
    true  => "Class['awscli::deps']",
    false => undef,
  }
  if $manage_deps {
    class { '::awscli::deps':
      proxy => $proxy,
    }
  }

  package { 'awscli':
    ensure          => $version,
    provider        => 'pip',
    install_options => $install_options,
    require         => [
      Package['pip'],
      Class['awscli::deps'],
    ],
  }
}
