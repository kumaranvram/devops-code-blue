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
  
  class {"dristhi::tomcat":
    user => "${user}",
    require => User["${user}"],
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
