class profile::sample_app::windows {

  $app_base = 'C:/app'
  $java_path = 'C:/Program Files (x86)/Common Files/Oracle/Java/javapath/java.exe'
  $app_location = "${app_base}/puppet_webapp.jar"

  file{ $app_base:
    ensure => directory,
  }

  file {$app_location:
    ensure  => present,
    source  => "puppet:///modules/profile/puppet_webapp.jar",
    require => File[$app_base],
  }

  package {['jre8','nssm']:
    ensure   => present,
    provider => 'chocolatey',
  }

  exec {'install_service':
    command  => "nssm install puppet_webapp \"${java_path}\" \"-jar ${app_location}\"",
    provider => 'powershell',
    notify   => Service['puppet_webapp'],
    unless   => "if (!(nssm get puppet_webapp Application | select-string \"${java_path}\" -quiet)){ exit 1 }",
  }

  exec {'set_args':
    command  => "nssm set puppet_webapp AppParameters \"-jar ${app_location}\"",
    provider => 'powershell',
    require  => Exec['install_service'],
    notify   => Service['puppet_webapp'],
    unless   => "if (!(nssm get puppet_webapp AppParameters| select-string \"${app_location}\" -quiet)){ exit 1 }",
  }

  exec {'set_stdout_log':
    command  => "nssm set puppet_webapp AppStdout \"${app_base}/stdout.log\"",
    provider => 'powershell',
    notify   => Service['puppet_webapp'],
    require  => Exec['set_args'],
    unless   => "if (!(nssm get puppet_webapp AppStdout| select-string \"${app_base}/stdout.log\" -quiet)){ exit 1 }",
  }

  exec {'set_stderr_log':
    command  => "nssm set puppet_webapp AppStderr \"${app_base}/stderr.log\"",
    provider => 'powershell',
    require  => Exec['set_stdout_log'],
    notify   => Service['puppet_webapp'],
    unless   => "if (!(nssm get puppet_webapp AppStderr| select-string \"${app_base}/stderr.log\" -quiet)){ exit 1 }",
  }

  service {'puppet_webapp':
    ensure  => running,
    require => Exec['install_service'],
  }

}
