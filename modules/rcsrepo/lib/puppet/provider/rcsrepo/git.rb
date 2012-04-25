Puppet::Type.type(:rcsrepo).provide(:git) do
  commands :git => 'git'

  def exists?
    File.directory?(File.join(resource[:path],'.git'))
  end

  def create
    begin
      if resource[:source]
        git('clone', resource[:source], resource[:path])
      else
        git('init', resource[:path])
      end
    rescue Puppet::ExecutionFailure => e
      raise Puppet::Error, "Failed to create repository: #{e.message}"
    end
    true
  end

  def destroy
    FileUtils.rm_rf(resource[:path])
  end

  def revision
    git('--git-dir', File.join(resource[:path], '.git'), 'rev-parse','HEAD')
  end

  #private

  #def git(args)
  #  gitcmd('--work-tree', resource[:path], '--git-repo', File.join(resource[:path], '.git'), args)
  #end
end
