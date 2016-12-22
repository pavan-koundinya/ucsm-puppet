#!/usr/bin/python
# -*- mode: python -*-

# Copyright 2015 Cisco Systems, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DOCUMENTATION = '''
---
module: boot_policy
short_description: Create, modify or remove boot policy 

description:
  - Allows to check if boot policy exists. If present, check for desired configuration. If desired config is not present, apply settings. If boot policy is not present, create and apply desired settings. If the desired state is 'absent', remove boot policy if it is currently present
 
version_added: "0.1.0"
author: 
    - "Cisco UCS Team"
    - "Pavan Koundinya"
'''


from ucsmsdk.mometa.lsboot.LsbootPolicy import LsbootPolicy
from ucsmsdk.mometa.lsboot.LsbootBootSecurity import LsbootBootSecurity
from ucsmsdk.mometa.lsboot.LsbootLan import LsbootLan
from ucsmsdk.mometa.lsboot.LsbootLanImagePath import LsbootLanImagePath
from ucsmsdk.mometa.lsboot.LsbootSan import LsbootSan
from ucsmsdk.ucshandle import UcsHandle
import json
import jsonpickle
import hiera
import pickle
import ucs_login

def boot_policy(hiera_client):

    name = hiera_client.get('name')
    print("name"+name)
    descr = hiera_client.get('descr')
    reboot_on_update = hiera_client.get('reboot_on_update')
    policy_owner = hiera_client.get('policy_owner')
    enforce_vnic_name = hiera_client.get('enforce_vnic_name')
    boot_mode = hiera_client.get('boot_mode')
    state = hiera_client.get('state')

    results = {}

    ucs_handle = pickle.loads(str(ucs_login.main()))

###-------CHECK IF MO EXISTS---------------------------------

    try:

	mo = ucs_handle.query_dn("org-root/boot-policy-"+name)
	print(mo)
    except:
        print("Could not query children of org-root")


###----if expected state is "present"------------------------

    if state == "present":

	    if mo:

			if (mo.name == name and mo.descr == descr and 	mo.boot_mode == boot_mode and mo.reboot_on_update == reboot_on_update and mo.policy_owner == policy_owner and mo.enforce_vnic_name == enforce_vnic_name):
				results['expected'] = True;
				results['changed'] = False;
				results['present'] = True;
				results['mo_bootpolicy'] = json.dumps(json.loads(jsonpickle.encode(mo)));


			else:
		    		try:
					mo.descr = descr
					mo.boot_mode = boot_mode
					mo.reboot_on_update = reboot_on_update
					mo.policy_owner = policy_owner
					mo.enforce_vnic_name = enforce_vnic_name
					results['expected'] = False;
					results['changed'] = True;
					results['present'] = True;
					ucs_handle.set_mo(mo)
					ucs_handle.commit()
					results['mo_bootpolicy'] = json.dumps(json.loads(jsonpickle.encode(mo)));


		   		except:
					module.fail_json(msg="Modify boot policy mo failed")

###----------if not, create boot policy with desired config ----------------

	    else:
	    	try:
			print("inside creator block")
			mo = LsbootPolicy(parent_mo_or_dn="org-root", name=name, descr=descr, reboot_on_update=reboot_on_update, policy_owner=policy_owner, enforce_vnic_name=enforce_vnic_name, boot_mode=boot_mode)
			results['present'] = False;
			results['created'] = True;
			results['changed'] = True;
			results['mo_bootpolicy'] = json.dumps(json.loads(jsonpickle.encode(mo)));

			ucs_handle.add_mo(mo)
			ucs_handle.commit()
			

	   	except:
			print("Boot Policy creation failed")


###------if expected state is "absent"----------------------------

    if state == "absent":

	    if mo:

    		try:
			ucs_handle.remove_mo(mo)
			results['present'] = False;
			results['removed'] = True;
			ucs_handle.commit()

   		except:
			print("Remove boot policy mo failed")

	    else:

    		results['removed'] = False;
		results['present'] = False;
    return results

def main():
    hiera_client = hiera.HieraClient('/etc/puppet/modules/ucsm-puppet/hiera.yaml',environment='dev')
    results = boot_policy(hiera_client)
    print(results)
    return results

if __name__ == '__main__':
    main()

