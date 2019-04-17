class profile::baseline::linux::ssh_config {
  class{ '::ssh':
    permit_root_login           => 'yes',
    sshd_client_alive_interval  => '7200',
    sshd_client_alive_count_max => '0',
  }
}