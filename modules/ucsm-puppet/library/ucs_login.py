#!/usr/bin/python
import hiera
from ucsmsdk.ucshandle import UcsHandle
import json
import jsonpickle
import pickle
class ucs_login:
    def ucs_login(self,hiera_client):
    	ip = hiera_client.get('ip')
    	username = hiera_client.get('username')
    	password = hiera_client.get('password')

    	results = {}

    	handle = UcsHandle(ip, username, password)
    	try:
            handle.login()
	    #mo = handle.query_dn("org-root/boot-policy-ciscotest")
    	    #print(mo)
    	    results['logged_in'] = True
	    print("Logged In !!!!")
    	except:
            print("login failed")
	#print(type(handle))
    	return handle

def main():
    hiera_client = hiera.HieraClient('/etc/puppet/modules/ucsm-puppet/hiera.yaml',environment='dev')
    loginInstance=ucs_login()
    handle = loginInstance.ucs_login(hiera_client)
    ucs_handle=pickle.dumps(handle)
    #print(type(ucs_handle))
    return ucs_handle
if __name__ == '__main__':
    main()

