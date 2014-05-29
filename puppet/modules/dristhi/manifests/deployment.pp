class dristhi::deployment ($user) {
  $env_name = "vagrantvm"

  file { "deploy_script.sh":
    ensure  => file,
    path    => "/home/${user}/deploy_script.sh",
    content => template("dristhi/deploy_script.erb"),
    mode    => "755",
    owner   => $user,
    group   => $user,
  }

  file { "ant_script.sh":
    ensure  => file,
    path    => "/home/${user}/ant_script.sh",
    content => template("dristhi/ant_script.erb"),
    mode    => "755",
    owner   => $user,
    group   => $user,
  }

  exec { "install_dristhi":
    path    => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
    cwd     => "/home/${user}",
    command => "/bin/sh ./deploy_script.sh",
    user    => "${user}",
    require => File["deploy_script.sh"],
  }

  file { "${env_name}":
    ensure  => directory,
    path    => "/home/${user}/drishti-delivery/properties/${env_name}",
    require => Exec["install_dristhi"],
  }

  file { "activemq.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/activemq.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/activemq.properties"),
    require => File["${env_name}"],
  }

  file { "couchdb.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/couchdb.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/couchdb.properties"),
    require => File["${env_name}"],
  }

  file { "deploy.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/deploy.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/deploy.properties"),
    require => File["${env_name}"],
  }

  file { "drishti.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/drishti.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/drishti.properties"),
    require => File["${env_name}"],
  }

  file { "osgi.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/osgi.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/osgi.properties"),
    require => File["${env_name}"],
  }

  file { "quartz.properties":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/quartz.properties",
    ensure  => present,
    content => template("dristhi/${env_name}/quartz.properties"),
    require => File["${env_name}"],
  }

  file { "log4j.xml":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/log4j.xml",
    ensure  => present,
    content => template("dristhi/${env_name}/log4j.xml"),
    require => File["${env_name}"],
  }

  file { "reporting_folder":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/reporting",
    ensure  => directory,
    require => File["${env_name}"],
  }

  file { "reporting-log4j.xml":
    path    => "/home/${user}/drishti-delivery/properties/${env_name}/reporting/log4j.xml",
    ensure  => present,
    content => template("dristhi/${env_name}/log4j.xml"),
    require => File["reporting_folder"],
  }

}