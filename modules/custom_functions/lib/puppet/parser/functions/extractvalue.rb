require 'yaml'
Puppet::Parser::Functions.newfunction(:extractvalue, :type => :rvalue, :doc => "This function will take two arguments, a path to a yaml file and a field in the yaml file, and extract the value.") do |args|
  raise Puppet::ParseError, "Expected 2 arguments, got #{args.length}" if args.length != 2
  raise Puppet::Error, "File #{args[0]} does not exist" if ! File.exists?(args[0])
  YAML.load_file(args[0])[args[1]]
end
