class dristhi::deployment ($user) {
  file { 'deploy_script.sh':
    ensure  => file,
    path    => "/home/${user}/deploy_script.sh",
    content => template('dristhi/deploy_script.erb'),
    mode    => '755',
    owner   => $user,
    group   => $user,
  } 
  exec { 'install_dristhi':
    path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    cwd     => "/home/${user}",
    command => "/bin/sh ./deploy_script.sh",
    user    => "${user}",
    require => File['deploy_script.sh'],
  } 
  file { 'vagrantvm':
    ensure => directory,
    path   => "/home/${user}/drishti-delivery/properties/vagrantvm",
    require => Exec['install_dristhi'],
  }

  file { 'activemq.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/activemq.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/activemq.properties'),
    require => File['vagrantvm'],
  }

  file { 'couchdb.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/couchdb.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/couchdb.properties'),
    require => File['vagrantvm'],
  }

  file { 'deploy.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/deploy.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/deploy.properties'),
    require => File['vagrantvm'],
  }

  file { 'drishti.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/drishti.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/drishti.properties'),
    require => File['vagrantvm'],
  }

  file { 'osgi.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/osgi.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/osgi.properties'),
    require => File['vagrantvm'],
  }

  file { 'quartz.properties':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/quartz.properties",
    ensure  => present,
    content => template('dristhi/vagrantvm/quartz.properties'),
    require => File['vagrantvm'],
  }

  file { 'log4j.xml':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/log4j.xml",
    ensure  => present,
    content => template('dristhi/vagrantvm/log4j.xml'),
    require => File['vagrantvm'],
  }

  file { 'reporting_folder':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/reporting",
    ensure  => directory,
    require => File['vagrantvm'],
  }

  file { 'reporting-log4j.xml':
    path    => "/home/${user}/drishti-delivery/properties/vagrantvm/reporting/log4j.xml",
    ensure  => present,
    content => template('dristhi/vagrantvm/log4j.xml'),
    require => File['reporting_folder'],
  }

}