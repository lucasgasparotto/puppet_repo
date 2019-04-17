class time {
  $servers = ['time.google.com']
    case $::kernel {
      'windows': {
        class { 'winntp':
          servers => $servers,
        }
    }
    default: {
      class { 'ntp':
        servers => $servers,
      }
    }
  }
}