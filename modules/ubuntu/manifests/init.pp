class ubuntu (
  $common_packages = [],
  ){

  package { $common_packages:
    ensure => "installed"
  }
}
