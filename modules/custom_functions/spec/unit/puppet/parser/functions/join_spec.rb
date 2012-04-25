require 'puppet'
describe Puppet::Parser::Functions.function(:join) do
  let :scope do
    Puppet::Parser::Scope.new
  end
  it "should turn an array of items into a string" do
    scope.function_join([['foo','bar','baz'], ':']).should == 'foo:bar:baz'
  end
  it "should fail if no arguments are supplied" do
    expect { scope.function_join([]) }.to raise_error Puppet::ParseError
  end
  it "should fail if too few arguments are supplied" do
    expect { scope.function_join(["foo"]) }.to raise_error Puppet::ParseError
  end
  it "should fail if too many arguments are supplied" do
    expect { scope.function_join(["foo","bar","baz"]) }.to raise_error Puppet::ParseError
  end
  it "should fail if the first argument is not an array" do
    expect { scope.function_join(["foo","bar"]) }.to raise_error Puppet::ParseError
  end
  it "should fail if the second argument is not a string" do
    expect { scope.function_join([["foo"],["bar"]]) }.to raise_error Puppet::ParseError
  end
end
