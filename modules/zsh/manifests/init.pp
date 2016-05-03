class zsh {
  # This define is copied from accounts::user.
  # I will only use the hiera data for accounts
  # when doing user stuff.
  define copy_config (
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


    file { "$home/$username/.antigen/":
      ensure  => directory,
      source  => 'puppet:///modules/zsh/antigen',
      recurse => true,
      owner   => $username,
      group   => $username,
    }

    file { "$home/$username/.zshrc":
      source  => 'puppet:///modules/zsh/zshrc',
      owner   => $username,
      group   => $username,
      mode    => '0664'
    }
  }

  $accounts = hiera("accounts::users")
  create_resources( copy_config, $accounts)
}
