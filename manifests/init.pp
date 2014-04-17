file { "/home/motech":
    ensure => "directory"
}

user { "motech":
    ensure => "present",
    home => "/home/motech",
    password => "apple phone mouse"
}
