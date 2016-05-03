class ubuntu::desktop (
  $packages = [],
  ){
  package { $packages:
    ensure  => "installed",
  }

  # Changes the default playback application for media to VLC
  file { "/usr/share/applications/defaults.list":
    source  => 'puppet:///modules/ubuntu/applications_default.list',
    owner   => 'root',
    group   => 'root',
    mode    => '0644'
  }
}
