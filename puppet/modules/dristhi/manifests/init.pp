include apache
include activemq
include rpmrepos::epel

class dristhi($user) {
  
#  group { "${user}": ensure => "present",
#    
#  }
#  
#  user { "${user}":
#    ensure => present,
#    gid => $user,
#    managehome => true,
#    require  => Group["${user}"],
#    shell      => "/bin/bash",
#  } 

#	class{'sudo':} ->
#	  sudo::conf { "${user}":
#	      priority => 10,
#	      content  => "${user} ALL=(ALL) ALL\n",
#  }
	
	package {'git':
	  ensure => present,
	}  

  package { 'wget': 
    ensure => installed, 
  }

  class { 'jdk_oracle': 
    require => Package['wget'],
  }

  file {'java_home':
     path => '/etc/profile.d/java.sh',
     content => "export JAVA_HOME=/opt/jdk1.7.0",
     require => Class['jdk_oracle'],
  }   

  class {"dristhi::tomcat":
    user => "${user}",
    require => File['java_home'],
  } 
  
  class{"dristhi::ant":
    user => "${user}",
  }
  
  class { 'postgresql::server': }

  postgresql::server::db { 'drishti':
    user     => 'postgres',
    password => postgresql_password('postgres', 'password'),
  }
  postgresql::server::database_grant { 'drishti':
      privilege => 'ALL',
      db        => 'drishti',
      role      => 'postgres',
  }
  class { 'couchdb':  }
  
  class {'dristhi::deployment': 
    user   => $user, 
    require => Class['jdk_oracle'],
  }
  
}
