class special_packages::charles () {

  apt::source { 'charles-proxy':
    location    => 'http://www.charlesproxy.com/packages/apt/',
    repos       => 'main',
    key         => {
      id     => '29A78E603B29AC9A889235E6500CCEC520E0B5BF',
      source => 'http://www.charlesproxy.com/packages/apt/PublicKey',
    },
    release     => 'charles-proxy',
    include     => {
      'src'  => false,
      'deb'  => true,
    }
  }

  exec { 'charles-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => [ Apt::Source['charles-proxy'] ]
  }

    package { 'charles-proxy':
    ensure  => 'installed',
    require => Apt::Source['charles-proxy']
  }
}
