class profile::sample_app::linux {

  $app_base = '/app'
  $app_location = "${app_base}/puppet_webapp.jar"
  $java_path = '/bin/java'

  file{ $app_base:
    ensure => directory,
  }

  file { $app_location:
    ensure  => present,
    source  => "puppet:///modules/profile/puppet_webapp.jar",
    require => File[$app_base],
  }

  package {'java-1.8.0':
    ensure   => present,
  }

  $systemd = @("INIT"/L)
      [Unit]
      Description=Puppet WebApp
      Wants=basic.target
      After=basic.target network.target

      [Service]
      Type=simple
      WorkingDirectory=/app
      ExecStart=/bin/bash -c "${java_path} -jar ${app_location}"
      SyslogIdentifier=puppet_webapp

      [Install]
      WantedBy=multi-user.target
      | INIT

  file { '/lib/systemd/system/puppet_webapp.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => $systemd,
  }

  exec { 'systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => $::path,
    refreshonly => true,
    subscribe   => File['/lib/systemd/system/puppet_webapp.service'],
  }

  service { 'puppet_webapp':
    ensure  => running,
    enable  => true,
    require => [
      Package['java-1.8.0'],
      File[$app_location],
    ]
  }

}
