class ubuntu (
  $common_packages = [],
  ){

  class { 'apt':
    always_apt_update => false,
  }

  class { 'apt::unattended_upgrades':
    update    => '1',
    upgrade   => '1',
    autoclean => '7',
  }

  package { $common_packages:
    ensure => "installed"
  }

  define copy_config {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    file { "$home_dir/$user/.bashrc":
      path    => "$home_dir/$user/.bashrc",
      source  => 'puppet:///modules/ubuntu/bashrc',
      owner   => $user,
      group   => $user,
    }
  }
  $users = hiera("users::local_users")
  copy_config { $users: }
}
