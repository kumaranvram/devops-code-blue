
node 'localhost' {
  $user ='vagrant'
  class {'dristhi': user => $user}
		
}