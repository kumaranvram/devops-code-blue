include apache
include wget
include jdk_oracle
include activemq
include rpmrepos::epel

class dristhi($user) {
  
  group { "${user}": ensure => "present",
    
  }
  
  user { "${user}":
    ensure => present,
    gid => $user,
    managehome => true,
    require  => Group["${user}"],
    shell      => "/bin/bash",
  } 

	class{'sudo':} ->
	  sudo::conf { "${user}":
	      priority => 10,
	      content  => "${user} ALL=(ALL) ALL\n",
  }
	
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
  
  class {'dristhi::deployment': 
    user   => $user, 
  }
  
}
