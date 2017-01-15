class roles::boot_policy {
include profiles::ucs_login
include profiles::boot_policy
include profiles::ucs_logout

Class['profiles::ucs_login'] ->Class['profiles::boot_policy'] -> Class['profiles::ucs_logout']
}

