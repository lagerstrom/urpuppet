class docker (
  $docker_users = [],
  ){

  group { 'docker':
    ensure => 'present',
  }

  apt::source { 'docker':
    location          => 'https://get.docker.com/ubuntu',
    repos             => 'main',
    key               => '36A1D7869245C8950F966E92D8576A8BA88D21E9',
    key_server        => 'hkp://keyserver.ubuntu.com:80',
    release           => 'docker',
    required_packages => 'apt-transport-https',
    include_src       => false
  }

  file { 'docker-compose':
    path   => '/usr/local/bin/docker-compose',
    source => 'puppet:///modules/docker/docker-compose',
    mode   => 0755,
    owner  => 'root',
  }

  User<|title == $docker_users |> {
    groups +> 'docker',
    require => Group['docker'],
  } ->
  package { 'lxc-docker':
    ensure => '1.6.0',
    require => Apt::Source['docker'],
  }
}
