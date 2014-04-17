file { "/home/motech":
    ensure => "directory"
}

user { "motech":
    ensure => "present",
    home => "/home/motech",
    password => "p@ssw0rd"
}
