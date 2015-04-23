class ubuntu::users {

  define add_users {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    group { $user:
      ensure => present,
    }

    user { $user:
      name       => $user,
      ensure     => present,
      shell      => '/bin/bash',
      home       => "$home_dir/$user",
      managehome => true,
      groups     => ['adm', 'cdrom', 'sudo', 'dip', 'plugdev'],
      gid        => $user,
      require    => Group[$user],
    }
  }

  $users = hiera("users::local_users")
  add_users { $users: }
}
