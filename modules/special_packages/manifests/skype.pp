class special_packages::skype () {

  apt::source { 'skype':
    location    => 'http://archive.canonical.com/',
    repos       => 'partner',
    release     => $::lsbdistcodename,
    include     => {
      'src'  => false,
      'deb'  => true,
    }
  }

  exec { 'skype-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => Apt::Source['skype']
    }->
    package { 'skype':
      ensure  => 'installed',
      require => Apt::Source['skype']
    }

}
