exec { 'pip':
	command => "/usr/bin/gem install puppet-pip",
	path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
	logoutput => true,

}
