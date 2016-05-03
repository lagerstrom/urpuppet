class awesome {

  $awesome_packages = [ 'awesome', 'awesome-extra', 'xbacklight' ]

  package { $awesome_packages:
    ensure => installed,
  }

  # This define is copied from accounts::user.
  # I will only use the hiera data for accounts
  # when doing user stuff.
  define setup_awesome (
    $uid = undef,
    $gid = $uid,
    $primary_group = "${title}",
    $comment = "${title}",
    $username = "${title}",
    $groups = [],
    $ssh_key = '',
    $ssh_keys = {},
    $purge_ssh_keys = false,
    $shell ='/bin/bash',
    $pwhash = '',
    $managehome = true,
    $manage_group = true,
    $home = '/home', # This line was changed from undef to '/home'
    $home_permissions = '0755',
    $ensure = present,
    $recurse_permissions = false,
  )
  {

    # Ensure that the config dir exists
    # where we will then put the config file
    file { "$home/$username/.config":
      ensure => directory,
    }

    # Copy the config file to correct place
    file { "$home/$username/.config/awesome":
      path         => "$home/$username/.config/awesome",
      ensure       => directory,
      source       => 'puppet:///modules/awesome/awesome_config',
      recurse      => true,
      require      => File["$home/$username/.config"],
      owner        => $username,
      group        => $username,
    }

    # Create $home/$username/.gconf/apps/gnome-terminal/profiles/Default recursivly
    $directories = [
                    "$home/$username/.gconf",
                    "$home/$username/.gconf/apps",
                    "$home/$username/.gconf/apps/gnome-terminal",
                    "$home/$username/.gconf/apps/gnome-terminal/profiles",
                    "$home/$username/.gconf/apps/gnome-terminal/profiles/Default",
                   ]
    file { $directories :
      ensure => "directory",
      owner => $username,
      group => $username,
      mode  => '0600'

    }

    # Copy the config file to remove the menu bar.
    file { 'gnome-terminal-config':
      path => "$home/$username/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml",
      source       => 'puppet:///modules/awesome/gnome-terminal-gconf.xml',
      require      => [ File[ $directories ], User[ $username ] ],
      owner => $username,
      group => $username,
      mode  => '0600'
    }

    # Add alias script, like the spotify launcher
    file { "copy_scripts":
      path         => "$home/$username/bin",
      ensure       => directory,
      source       => 'puppet:///modules/awesome/bin',
      recurse      => true,
      owner        => $user,
      group        => $user,
    }
  }



  $accounts = hiera("accounts::users")
  create_resources( setup_awesome, $accounts)
}
