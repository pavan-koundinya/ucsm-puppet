Puppet::Type.type(:ucs_login).provide :ruby do
  mk_resource_methods

  def self.handle
    ip =@resource[:ip]
    username =@resource[:username]
    password=@resource[:password]
    current = Puppet::Util::Execution.execute(
      "python /etc/puppet/manifests/ucs_login.py #{ip} #{username} #{password}",
      :failonfail => true
    )
  notice("#{current}")
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


  def self.instances
    dummy={}
    dummy[:name]='login'
    dummy[:ip]='172.31.219.215'
    dummy[:username]='ucspe'
    dummy[:password]='ucspe'
    new(dummy)
  end

  def self.prefetch(resources)
      prov=instances
      #Puppet.debug("The main line is  :: #{resources[prov.name]}")
      if @resource = resources[prov.name]
        #Puppet.debug("Inside if statement")
        @resource.provider = prov
      end
    handle
  end
end
