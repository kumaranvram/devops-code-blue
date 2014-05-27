class dristhi($user = 'motech') {
  user { "${user}":
    ensure => present,
    managehome => true;
  } 
  file {"/etc/environment":
    ensure=>"present",
    content=>"PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" 
  }
	package {'git':
	  ensure => present,
	}  

	vcsrepo { "/home/${user}/SEL-Columbia":
	  ensure   => present,
	  provider => git,
	  source   => 'https://github.com/SEL-Columbia/dristhi.git',
	  owner  => "${user}",
    require => [Package['git'], User["${user}"]],
  }
  
  file {'java_home':
     path => '/etc/profile.d/java.sh',
     content => "export JAVA_HOME=/opt/jdk1.7.0",
  }  

  class {"dristhi::tomcat":
    user => "${user}",
    require => [User["${user}"], File['java_home']],
  }
  
  class{"dristhi::ant":
    user => "${user}",
    require => User["${user}"],
  }
  
  class { 'postgresql::server': }

  postgresql::server::db { 'drishti':
    user     => 'postgres',
    password => postgresql_password('postgres', 'password'),
  }
  
  class { 'couchdb':}
  
  file{'deploy_script.sh':
    ensure  => file,
    path    => "/home/${user}/deploy_script.sh",
    content => template('dristhi/deploy_script.erb'),
    mode    => '755',
    owner   =>  $user,
    group   => $user,
    require  => User["${user}"],
  }

}
