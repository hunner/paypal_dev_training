IO.popen('yum list installed').readlines.each do |line|
  m = line.match(/^([\w-]+)\.\S*\s+(\S+)/)
  Facter.add("yum_#{m[1]}_version") do
   confine :has_yum => true
   setcode { m[2] }
  end if m
end
