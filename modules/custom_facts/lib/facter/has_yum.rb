Facter.add(:has_yum) do
  setcode do
    system "which yum > /dev/null"
    $?.success?
  end
end
