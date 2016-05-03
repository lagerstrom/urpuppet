class emacs {

  package { 'emacs24-nox' :
    ensure => installed,
  }

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


    # Copies everything in the emacs.d folder to
    # every users home folder.
    file { "$home/$username/.emacs.d/":
      ensure  => directory,
      source  => 'puppet:///modules/emacs/emacs.d',
      recurse => true,
      owner   => $username,
      group   => $username,
    }

    # python3-virtualenv is needed for jedi to work
    package { 'python3-virtualenv':
      ensure => 'installed',
    }

    # virtualenv is needed for jedi to work
    package { 'virtualenv':
      ensure => 'installed',
    }


    # This creates a python3 virtualenv for jedi to use
    exec { 'jedi_virtualenv':
      command     => "/usr/bin/virtualenv -p /usr/bin/python3 ${home}/${username}/.emacs.d/.python-environments/jedi",
      require     => [
                      File["${home}/${username}/.emacs.d/"],
                      Package['python3-virtualenv'],
                      Package['virtualenv'],
                      ],
      user        => $username,
      refreshonly => true,
      subscribe   => File["${home}/${username}/.emacs.d/"],
      }->
      exec { 'install_jedi':
        command => "${home}/${username}/.emacs.d/.python-environments/jedi/bin/pip install --upgrade ${home}/${username}/.emacs.d/.python-environments/jedi-dependencies/",
        user    => $username,
        refreshonly => true,
      }
      # Above there is a arrow, this means that the thing that should run
      # after the function above is the one after.
      # In this case it will install all necessary dependencies for jedi.


    # Copies the emacs.conf file to .emacs in the user home folders.
    file { "$home/$username/.emacs":
      source  => 'puppet:///modules/emacs/emacs.conf',
      owner   => $username,
      group   => $username,
      mode    => '0664'
    }
  }

  $accounts = hiera("accounts::users")
  create_resources( copy_config, $accounts)
}
