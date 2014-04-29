include apache
include java

node 'localhost' {
	user { 'motech':
		ensure => present,
		managehome => true;
	}	
}