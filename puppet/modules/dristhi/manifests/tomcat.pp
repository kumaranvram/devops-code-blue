class dristhi::tomcat($user){
  
  $tomcat_installation_package = "apache-tomcat-7.0.42"
  $url = "http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.42/bin/${tomcat_installation_package}.tar.gz"
  $filename = 'apache-tomcat-7.0.42'
  
  file{"/home/$user/tomcat7":
    ensure => directory,
    owner => $user
  }
  #Download, extract, configure and compile tomcat with just download url.
  puppi::netinstall{"tomcat7":
     path            => '/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin',
      url             => $url,
      destination_dir => "/home/${user}/tomcat7",
      owner           => $user,
      require         => File["/home/${user}/tomcat7"],
  }
  file { "/etc/init.d/tomcat":
    ensure  => present,
    content => template("dristhi/etc/init.d/tomcat.erb"),
    owner   => $user,
    mode    => '755',
  } ->
  service { "tomcat":
    ensure => running,
    enable => true,
  }
}
