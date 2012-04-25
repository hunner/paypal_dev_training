i = 0
`yum list installed`.each do |line|
  i += 1
  next if i <= 2
  package, version, garbage = line.split(' ', 3)
  package = package.split('.')[0]
  Facter.add("yum_#{package}_split") do
    setcode { version }
  end
end
