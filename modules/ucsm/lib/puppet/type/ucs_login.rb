Puppet::Type.newtype(:ucs_login) do
  desc "Puppet type that logges into UCSPE"
  newparam(:name ,:namevar => true) do
    desc "The handle object"
  end

  newproperty(:ip) do
    desc "Server IP Address of UCSPE"
  end

  newproperty(:username) do
    desc "Username for authentication"
  end

  newproperty(:password) do
    desc "Password for authentication"
  end
end
