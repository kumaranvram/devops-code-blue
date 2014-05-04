class dristi($user = 'motech') {
  user { "${user}":
    ensure => present,
    managehome => true;
  } 
  
	package {'git':
	  ensure => present,
	}  

#todo: use ssh.
	vcsrepo { "/home/${user}/SEL-Columbia":
	  ensure   => present,
	  provider => git,
	  source   => 'https://github.com/SEL-Columbia/dristhi.git',
	  owner  => "${user}",
    require => [Package['git'], User['motech']],
  }

}
