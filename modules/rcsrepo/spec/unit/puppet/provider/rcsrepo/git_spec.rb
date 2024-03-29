require 'puppet'
require 'fileutils'
require 'mocha'
RSpec.configure do |config|
  config.mock_with :mocha
end

describe 'The git provider for the rcsrepo type' do
  let(:test_dir) { File.join('/tmp', Time.now.to_i.to_s, 'repo') }
  let(:resource) { Puppet::Type::Rcsrepo.new({:path => test_dir}) }
  subject { Puppet::Type.type(:rcsrepo).provider(:git).new(resource) }

  it 'should be able to detect if a repo does not exist' do
    subject.exists?.should == false
  end
  it 'should be able to create a repo without a source' do
    subject.create.should == true
  end
  it 'should be able to detect if a repo exists' do
    subject.create
    subject.exists?.should == true
  end
  it 'should be able to create a repo with a source' do
    subject.resource[:source] = 'http://github.com/hunner/progress_mq.git'
    subject.create.should == true
    subject.exists?.should == true
  end
  it 'should be able to destroy a repo' do
    subject.exists?.should == false
    subject.create
    subject.exists?.should == true
    subject.destroy.should == true
    subject.exists?.should == false
  end
  it 'should be able to get the revision' do
    subject.resource[:source] = 'http://github.com/hunner/progress_mq.git'
    subject.create
    subject.revision.should == '59a2fba50028cbb2518ea767964a1808b64f2b14'
  end
  it 'should be able to set the revision at creation time' do
    subject.resource[:source] = 'http://github.com/hunner/progress_mq.git'
    subject.resource[:revision] = '258050c861a83d804be714ec5c94bafcae76be70'
    subject.create
    subject.revision.should == '258050c861a83d804be714ec5c94bafcae76be70'
  end
  it 'should be able to set the revision after creation' do
    subject.resource[:source] = 'http://github.com/hunner/progress_mq.git'
    subject.create
    subject.revision = '258050c861a83d804be714ec5c94bafcae76be70'
    subject.revision.should == '258050c861a83d804be714ec5c94bafcae76be70'
  end

  after :each do
    FileUtils.rm_rf(File.dirname(test_dir)) if File.exists?(test_dir)
  end
end
