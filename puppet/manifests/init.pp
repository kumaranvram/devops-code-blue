include apache
include wget
include jdk_oracle
include activemq

node 'localhost' {
	user { 'motech':
		ensure => present,
		managehome => true;
	}	
}