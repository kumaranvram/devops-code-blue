include apache
include wget
include jdk_oracle
include activemq
include rpmrepos::epel

node 'localhost' {

  class {'dristi': }
  
	class { 'postgresql::server': }

	postgresql::server::db { 'drishti':
	  user     => 'postgres',
	  password => postgresql_password('postgres', 'password'),
	}
	
	class { 'couchdb': }
	
}