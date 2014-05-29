
node 'localhost' {
  $user = 'vagrant'

  class { "dristhi": user => $user }

  exec { 'Run deploy script':
    cwd       => "/home/${user}/drishti-delivery",
    command   => "/bin/sh /home/${user}/ant_script.sh",
    user      => "${user}",
    logoutput => "on_failure",
    require   => Class["dristhi"],
  }

}