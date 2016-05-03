class docker (){

  group { 'docker':
    ensure => 'present',
  }

  package { 'apt-transport-https' :
    ensure => 'installed',
  }

  apt::key { 'docker-key':
    id     => '36A1D7869245C8950F966E92D8576A8BA88D21E9',
    server => 'hkp://keyserver.ubuntu.com:80',
  }

  apt::source { 'docker':
    location          => 'https://get.docker.com/ubuntu',
    repos             => 'main',
    release           => 'docker',
    require           => [ Apt::Key['docker-key'], Package['apt-transport-https'] ],
    include           => {
      'src' => false,
      'deb' => true,
    },
  }

  exec { 'docker-update':
    command     => '/usr/bin/apt-get update',
    refreshonly => true,
    subscribe   => [ Apt::Key['docker-key'], Apt::Source['docker'] ]
  }

  exec { 'install_docker-compose':
    command => "/usr/bin/curl -L https://github.com/docker/compose/releases/download/1.5.2/docker-compose-${kernel}-${hardwaremodel} -o /usr/local/bin/docker-compose",
    creates => '/usr/local/bin/docker-compose'
    }->
    file { 'docker-compose':
      path   => '/usr/local/bin/docker-compose',
      mode   => '0755',
      owner  => 'root',
    }

  package { 'lxc-docker':
    ensure => 'latest',
    require => Apt::Source['docker'],
  }
}
