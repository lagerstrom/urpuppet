class youtube_dl (){

  if $operatingsystemrelease == '15.10' {
    package { 'libav-tools-links' :
      ensure => 'installed',
    }
  }
  else {
    package { 'libav-tools' :
      ensure => 'installed',
    }
  }

  exec { 'install_youtube_download':
    command => "/usr/bin/curl https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl",
    creates => '/usr/local/bin/youtube-dl'
    }->
    file { 'youtube-dl':
      path   => '/usr/local/bin/youtube-dl',
      mode   => '0755',
      owner  => 'root',
    }
}
