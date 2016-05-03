class special_packages::pycharm () {

  apt::source { 'pycharm':
    location    => 'http://ppa.launchpad.net/mystic-mirage/pycharm/ubuntu',
    repos       => 'main',
    key         => {
    id     => 'F8D6013A2FE38A80300EE40CDD969F10A7E2BCD2',
    server => 'keyserver.ubuntu.com',
    },
    release     => $::lsbdistcodename,
    include     => {
      'src'  => false,
      'deb'  => true,
    }
    }->
    exec { 'pycharm-update':
      command     => '/usr/bin/apt-get update',
      subscribe   => [ Apt::Source['pycharm'] ],
      refreshonly => true,
      }->
      package { 'pycharm-community':
        ensure  => 'installed',
        require => Apt::Source['pycharm']
      }
}
