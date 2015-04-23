class ubuntu::desktop (
  $packages = [],
  ){
  apt::source { 'spotify':
    location    => 'http://repository.spotify.com',
    repos       => 'non-free',
    key         => 'E22CBE98B5575C1857671254082CCEDF94558F59',
    key_server  => 'keyserver.ubuntu.com',
    release     => 'stable',
    include_src => false,
  }

  apt::source { 'google-chrome-stable':
    location    => 'http://dl.google.com/linux/chrome/deb/',
    repos       => 'main',
    key         => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
    key_source  => 'https://dl-ssl.google.com/linux/linux_signing_key.pub',
    release     => 'stable',
    include_src => false,
  }

  apt::source { 'skype':
    location    => 'http://archive.canonical.com/',
    repos       => 'partner',
    release     => $::lsbdistcodename,
    include_src => false,
  }


  apt::ppa { 'ppa:upubuntu-com/tor-bundle': }

  package { $packages:
    ensure  => "installed",
    require => [ Apt::Source['google-chrome-stable'],
                 Apt::Source['spotify'],
                 Apt::Source['skype'],
                 Apt::Ppa['ppa:upubuntu-com/tor-bundle'],
               ],
  }

}
