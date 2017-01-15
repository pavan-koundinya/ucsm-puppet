class profiles::ucs_login{

##Hiera lookups


exec { 'ucs_login':
	command => "/usr/bin/python /etc/puppet/modules/ucsm-puppet/library/ucs_login.py",
	path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
	logoutput => true,

}

}

class profiles::ucs_logout{

exec { 'ucs_logout':
        command => "/usr/bin/python /etc/puppet/modules/ucsm-puppet/library/ucs_logout.py",
        path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
        logoutput => true,

}

}



class profiles::boot_policy{

exec { 'boot_policy':
        command => "/usr/bin/python /etc/puppet/modules/ucsm-puppet/library/boot_policy.py",
        path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
        logoutput => true,

}

}
