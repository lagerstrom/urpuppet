class special_packages::hipchat () {

  apt::source { 'hipchat':
    location    => 'http://downloads.hipchat.com/linux/apt/',
    repos       => 'main',
    key         => {
      id     => '69F57C04EA38EEE7A47E9BCCAAD4AA21729B5780',
      source => 'https://www.hipchat.com/keys/hipchat-linux.key',
    },
    release     => 'stable',
    include     => {
      'src'  => false,
      'deb'  => true,
    }
  }

  exec { 'hipchat-update':
    command     => '/usr/bin/apt-get update',
    subscribe   => [ Apt::Source['hipchat'] ],
    refreshonly => true,
    }->
    package { 'hipchat':
      ensure  => 'installed',
      require => Apt::Source['hipchat']
    }
}
