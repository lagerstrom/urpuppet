class ubuntu::server (
  $packages = [],
  ){
  package { $packages:
    ensure  => "installed",
  }
}
