


Puppet::Type.newtype(:rcsrepo) do
  desc "Docs here"
  ensurable
  newparam(:path, :namevar => true) do
    validate do |value|
      raise Puppet::Error, "Path must be absolute: #{value}" unless value.match(/^\//)
    end
  end
  newparam(:source,:array_matching => :all) do
    desc "The source URL for the file"
    validate do |value|
      raise ArgumentError, "Source is not a valid URI: #{value}" unless URI.parse(value)
    end
  end
  newproperty(:revision) do
    desc "The revision which should be checked out"
    newvalues(/^\S+$/)
  end
end
