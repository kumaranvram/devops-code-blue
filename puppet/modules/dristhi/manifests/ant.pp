class dristhi::ant($user){
  $url = "http://www.interior-dsgn.com/apache//ant/binaries/apache-ant-1.9.4-bin.tar.gz"
  $filename = 'apache-ant-1.9.4'
  
  file{"/home/${user}/ant":
    ensure => directory,
    owner  => $user,
  }
  #Download, extract, configure and compile tomcat with just download url.
  puppi::netinstall{"ant":
     path            => '/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin',
      url             => $url,
      destination_dir => "/home/${user}/ant",
      extracted_dir   => "${filename}",
      owner           => $user,
      group           => $user,
      require        => File["/home/${user}/ant"],    
  }->
  file { "/usr/bin/ant":
    ensure  => 'link',
    target => "/home/${user}/ant/${filename}/bin/ant",
  }
}
