class emacs {

  $required_packages = [ 'emacs24-nox']

  package { $required_packages:
    ensure => installed,
  }

  define copy_config {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    file { "$home_dir/$user/.emacs.d/":
      path    => "$home_dir/$user/.emacs.d/",
      ensure  => directory,
      source  => 'puppet:///modules/emacs/emacs.d',
      recurse => true,
      owner   => $user,
      group   => $user,
    }

    file { "$home_dir/$user/.emacs":
      path    => "$home_dir/$user/.emacs",
      source  => 'puppet:///modules/emacs/emacs.conf',
      owner   => $user,
      group   => $user,
      mode    => 0664
    }
  }

  $users = hiera("users::local_users")
  copy_config { $users: }
}
