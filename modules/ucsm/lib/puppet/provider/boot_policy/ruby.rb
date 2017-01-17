Puppet::Type.type(:boot_policy).provide :ruby do
  mk_resource_methods

  def self.handle
     # Retriving all the parameters from the manifests
     name=@resource[:confuse]
     ip=@resource[:ip]
     username=@resource[:username]
     password=@resource[:password]
     descr=@resource[:descr]
     reboot_on_update=@resource[:reboot_on_update]
     policy_owner=@resource[:policy_owner]
     enforce_vnic_name=@resource[:enforce_vnic_name]
     boot_mode=@resource[:boot_mode]
     state=@resource[:state]
     #Call to the python script using puppet execute along with all the parameters 
     #get relative path to python code
     path = File.join(File.dirname(__FILE__), '..', '..', '..')
     current = Puppet::Util::Execution.execute(
      "python #{path}/boot_policy.py #{name}  '#{descr}'  #{reboot_on_update} #{policy_owner} #{enforce_vnic_name} #{boot_mode} #{state} #{ip} #{username} #{password}",
      :failonfail => true
     )
#     current = Puppet::Util::Execution.execute(
#      "python /etc/puppet/manifests/boot_policy.py #{name}  '#{descr}'  #{reboot_on_update} #{policy_owner} #{enforce_vnic_name} #{boot_mode} #{state} #{ip} #{username} #{password}",
#      :failonfail => true
#     )
  # Send notice of the output of the execute command
  notice("#{current}")
  end
#setter and getter for all properties specified in type
  def confuse
    resource[:confuse]
  end

  def confuse=(confuse) 
    @property_hash[:confuse]=confuse
  end

	
  def descr
    resource[:descr]
  end

  def descr=(descr)
    @property_hash[:descr]=descr
  end


  def ip
    resource[:ip]
  end

  def ip=(ip)
    @property_hash[:ip]=ip
  end

  def username
    resource[:username]
  end

  def username=(username)
    @property_hash[:username]=username
  end

  def password
    resource[:password]
  end

  def password=(password)
    @property_hash[:password]=password
  end


  def reboot_on_update
    resource[:reboot_on_update]
  end

  def reboot_on_update=(reboot_on_update)
    @property_hash[:reboot_on_update]=reboot_on_update
  end

  def enforce_vnic_name
    resource[:enforce_vnic_name]
  end

  def enforce_vnic_name=(enforce_vnic_name)
    @property_hash[:enforce_vnic_name]=enforce_vnic_name
  end

  def policy_owner
    resource[:policy_owner]
  end

  def policy_owner=(policy_owner)
    @property_hash[:policy_owner]=policy_owner
  end

  def boot_mode
    resource[:boot_mode]
  end

  def boot_mode=(boot_mode)
    @property_hash[:boot_mode]=boot_mode
  end

  def state
    resource[:state]
  end

  def state=(state)
    @property_hash[:state]=state
  end



  def self.instances
    #creating a dummy instance for the purpose of populating the resource values
    #Not exactly sure but its working !!!!
    dummy={}
    dummy[:name]='policy'
    dummy[:confuse]='policy'
    dummy[:ip]='ip'
    dummy[:username]='username'
    dummy[:password]='password'
    dummy[:descr]='descr'
    dummy[:reboot_on_update]='on/off'
    dummy[:policy_owner]='policy_owner'
    dummy[:enforce_vnic_name]='vnic'
    dummy[:boot_mode]='boot_mode'
    dummy[:state]='state'
    new(dummy)
  end

  def self.prefetch(resources)
     #retriving the dummy instance comparing the name and then setting the all       #property values for later access 
     prov=instances
     if @resource = resources[prov.name]
        @resource.provider = prov
     end
    #call to the self.handle method
    handle
  end
end
