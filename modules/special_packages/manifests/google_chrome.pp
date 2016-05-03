class special_packages::google_chrome () {

  apt::source { 'google-chrome-stable':
    location    => '[arch=amd64] http://dl.google.com/linux/chrome/deb/',
    repos       => 'main',
    key         => {
      id     => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
      source => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
    },
    release     => 'stable',
    include     => {
      'src'  => false,
      'deb'  => true,
    }
  }

  exec { 'google-chrome-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => Apt::Source['google-chrome-stable']
  }

  package { 'google-chrome-stable':
    ensure  => 'installed',
    require => Apt::Source['google-chrome-stable']
  }

}
