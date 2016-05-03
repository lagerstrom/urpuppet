class special_packages::tor_browser () {

  apt::source { 'tor-browser':
    location    => 'http://ppa.launchpad.net/webupd8team/tor-browser/ubuntu',
    repos       => 'main',
    key         => {
      id     => '7B2C3B0889BF5709A105D03AC2518248EEA14886',
      server => 'keyserver.ubuntu.com',
    },
    release     => $::lsbdistcodename,
    include     => {
      'src'  => false,
      'deb'  => true,
    }
    }->
    exec { 'tor-update':
      command     => '/usr/bin/apt-get update',
      subscribe   => [ Apt::Source['tor-browser'] ],
      refreshonly => true,
      }->
      package { 'tor-browser':
        ensure  => 'installed',
        require => Apt::Source['tor-browser']
      }
}
