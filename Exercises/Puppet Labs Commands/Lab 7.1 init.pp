class time {
  $servers = ['time.google.com']
  case $facts['kernel'] {
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