include apache
include wget
include jdk_oracle
include activemq

node 'localhost' {
	user { 'motech':
		ensure => present,
		managehome => true;
	}	
	class { 'postgresql::server': }

	postgresql::server::db { 'drishti':
	  user     => 'postgres',
	  password => postgresql_password('postgres', 'password'),
	}
}