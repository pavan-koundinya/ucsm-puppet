class ucsm::config inherits ucsm {

  notify { "name is $::name": }

  notify { "ip is $ucsm::ip": }

  notify { "user is $ucsm::user": }
  
  notify { "password is $ucsm::password": }

  notify { "boot policy name is $ucsm::boot_policy_name": }
  
  boot_policy{'policy':
    confuse => "$ucsm::boot_policy_name",
    descr => "$ucsm::boot_policy_descr",
    reboot_on_update => 'no',
    policy_owner => 'local',
    enforce_vnic_name => "$ucsm::boot_policy_enforce_vnic_name",
    boot_mode => 'legacy',
    state => 'present',     
    ip => "$ucsm::ip",
    username => "$ucsm::user",
    password => "$ucsm::password",
  }

}
