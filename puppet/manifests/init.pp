
node 'localhost' {
  $user ='vagrant'
  
  class {"dristhi": user => $user}
  
  exec{'Run deploy script':   
    cwd       =>  "/home/${user}",
    command   => "/bin/sh ant_script.sh",
    user      => "${user}",
    logoutput => "on_failure",
    require   => Class["dristhi"],
  }
		
}