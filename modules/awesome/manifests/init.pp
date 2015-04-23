class awesome {

  $awesome_packages = [ 'awesome', 'awesome-extra' ]

  package { $awesome_packages:
    ensure => installed,
  }

  define copy_config {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    file { "$home_dir/$user/.config":
      ensure => directory,
    }

    file { "$home_dir/$user/.config/awesome":
      path         => "$home_dir/$user/.config/awesome",
      ensure       => directory,
      source       => 'puppet:///modules/awesome/awesome_config',
      recurse      => true,
      require      => File["$home_dir/$user/.config"],
      owner        => $user,
      group        => $user,
    }

  }


  define remove_menu_bar {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    # Create $home_dir/$user/.gconf/apps/gnome-terminal/profiles/Default recursivly
    $directories = [
                    "$home_dir/$user/.gconf",
                    "$home_dir/$user/.gconf/apps",
                    "$home_dir/$user/.gconf/apps/gnome-terminal",
                    "$home_dir/$user/.gconf/apps/gnome-terminal/profiles",
                    "$home_dir/$user/.gconf/apps/gnome-terminal/profiles/Default",
                    "/tmp/$user"
                   ]
    file { $directories :
      ensure => "directory",
      owner => $user,
      group => $user,
      mode  => 0600

    }


    # Copy the config file to remove the menu bar.
    file { 'gnome-terminal-config':
      path => "$home_dir/$user/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml",
      source       => 'puppet:///modules/awesome/gnome-terminal-gconf.xml',
      require      => [ File[ $directories ], User[ $user ] ],
      owner => $user,
      group => $user,
      mode  => 0600
    }
  }


  define add_user_bin_dir {
    $home_dir = hiera('users::home_dir', '/home')
    $user = $name

    # Add alias script, like the spotify launcher
    file { "copy_scripts":
      path         => "$home_dir/$user/bin",
      ensure       => directory,
      source       => 'puppet:///modules/awesome/bin',
      recurse      => true,
      owner        => $user,
      group        => $user,
    }
  }




  $users = hiera("users::local_users")
  copy_config { $users: }
  remove_menu_bar { $users: }
  add_user_bin_dir { $users: }
}
