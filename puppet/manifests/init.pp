include apache
include wget
include jdk_oracle
include activemq
include rpmrepos::epel

node 'localhost' {

  class {'dristhi': }
		
}