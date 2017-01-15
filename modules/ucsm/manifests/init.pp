# Class: ucsm
# ===========================
#
# Full description of class ucsm here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'ucsm':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Cisco Systems, Inc
#
class ucsm (
  $ip 		= $ucsm::params::ip,
  $user		= $ucsm::params::user,
  $password	= $ucsm::params::password,
  $boot_policy_name = $ucsm::params::boot_policy_name,
  $boot_policy_descr = $ucsm::params::boot_policy_descr,
  $boot_policy_enforce_vnic_name = $ucsm::params::boot_policy_enforce_vnic_name,
  $lan_boot_order = $ucsm::params::lan_boot_order,
  $lan_boot_vnic_name = $ucsm::params::lan_boot_vnic_name,
) inherits ucsm::params {

#  validate_string($ip)
#  validate_string($user)
#  validate_string($password)
#  validate_string($boot_policy_name)
#  validate_string($boot_policy_descr)
#  validate_string($boot_policy_enforce_vnic_name)
#  validate_string($lan_boot_order)
#  validate_string($lan_boot_vnic_name)
  
#  anchor { 'ucsm::begin': } ->
#  class { '::ucsm::config': } ->
#  anchor { 'ucsm::end': }
  class { '::ucsm::config': }

}
