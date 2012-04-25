Puppet::Parser::Functions.newfunction(:join, :type => :rvalue) do |args|
  #require 'ruby-debug' ; debugger ; 1
  raise Puppet::ParseError, "Expected 2 arguments, got #{args.length}" if args.length != 2
  raise Puppet::ParseError, "First argument is not an array" unless args[0].is_a? Array
  raise Puppet::ParseError, "Second argument is not a string" unless args[1].is_a? String
  args[0].join(args[1])
end
