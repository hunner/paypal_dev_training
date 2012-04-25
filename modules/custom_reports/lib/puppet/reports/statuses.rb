Puppet::Reports.register_report(:statuses) do
  def process
    File.open(File.join(Puppet[:logdir],"statuses.txt"), 'a') do |f|
      if status != :unchanged
        resource_statuses.each do |resource_name, status_object|
          #require 'ruby-debug' ; debugger ; 1
          if status_object.change_count > 0
            f.puts "resource name => #{resource_name}"
            status_object.events.each do |event|
              f.puts "  property => #{event.property}"
              f.puts "    previous => #{event.previous_value}"
              f.puts "    desired  => #{event.desired_value}"
            end
          end
        end
      end
    end
  end
end
