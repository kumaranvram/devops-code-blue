include apache
include wget
include jdk_oracle
include activemq
include rpmrepos::epel

class dristhi($user = 'motech') {
  user { "${user}":
    ensure => present,
    managehome => true;
  } ->

	package {'git':
	  ensure => present,
	} -> 

  file {'java_home':
     path => '/etc/profile.d/java.sh',
     content => "export JAVA_HOME=/opt/jdk1.7.0",
  } ->  

  class {"dristhi::tomcat":
    user => "${user}",
    require => [User["${user}"], File['java_home']],
  } ->
  
  class{"dristhi::ant":
    user => "${user}",
    require => User["${user}"],
  }->
  
  class { 'postgresql::server': }->

  postgresql::server::db { 'drishti':
    user     => 'postgres',
    password => postgresql_password('postgres', 'password'),
  }->
  
  class { 'couchdb':}->
  
  file{'deploy_script.sh':
    ensure  => file,
    path    => "/home/${user}/deploy_script.sh",
    content => template('dristhi/deploy_script.erb'),
    mode    => '755',
    owner   =>  $user,
    group   => $user,
    require  => User["${user}"],
  }->
  exec{'install_dristhi':
    path     => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    cwd      => "/home/${user}",
    command  => "/bin/sh ./deploy_script.sh",
    user     => "${user}",
  }->
  exec{'create_vagrantvm':
    cwd      =>   '/home/motech/drishti-delivery/properties',
    command  =>   'cp -R dev vagrantvm',
  } ->
  file{'deploy.properties':
    path     =>   '/home/motech/drishti-delivery/properties/vagrantvm/deploy.properties',
    content  =>   template("dristhi/deploy.properties"), 
    
  }  
}
