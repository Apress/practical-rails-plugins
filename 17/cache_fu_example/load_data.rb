User.destroy_all
TrackListen.destroy_all
1.upto(5) do |number|
  puts "Creating User ##{number}"
  u = User.create!(:name=>"Test User #{number}", :login=>"user_#{number}")
  total = 20000
  total.times do |i|
      puts "#{i} of #{total} TrackListens created" if (i % 4000 == 0)
      u.track_listens.create!(:track_name=>"Test Song #{rand(300)}")
  end
end

