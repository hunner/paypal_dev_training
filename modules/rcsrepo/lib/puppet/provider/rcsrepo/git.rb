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
      self.revision = resource[:revision] if resource[:revision]
    rescue Puppet::ExecutionFailure => e
      raise Puppet::Error, "Failed to create repository: #{e.message}"
    end
    true
  end

  def destroy
    true if FileUtils.rm_rf(resource[:path])
  end

  def revision
    git_path('rev-parse','HEAD').chomp
  end

  def revision=(value)
    begin
      git_path('fetch','origin')
      git_path('checkout', value)
    rescue Puppet::ExecutionFailure => e
      raise Puppet::Error, "Unable to set revision: #{e.message}"
    end
    true
  end

  private

  def git_path(*args)
    git('--work-tree', resource[:path], '--git-dir', File.join(resource[:path], '.git'), args)
  end
end
