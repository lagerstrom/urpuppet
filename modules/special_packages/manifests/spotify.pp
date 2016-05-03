class special_packages::spotify () {

  apt::key { 'spotify-key':
    id     => 'BBEBDCB318AD50EC6865090613B00F1FD2C19886',
    server => 'keyserver.ubuntu.com',
  }

  apt::source { 'spotify':
    location    => 'http://repository.spotify.com',
    repos       => 'non-free',
    release     => 'testing',
    require     => Apt::Key['spotify-key'],
    include     => {
      'src'  => false,
      'deb'  => true,
    }
  }

  exec { 'spotify-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => [ Apt::Key['spotify-key'], Apt::Source['spotify'] ]
  }

  package { 'spotify-client':
    ensure  => 'installed',
    require => Apt::Source['spotify']
  }

}
