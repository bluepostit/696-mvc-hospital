require_relative 'patient'
require_relative 'room'

bob = Patient.new({ name: 'bob', cured: false })
sally = Patient.new(name: 'sally', cured: true, id_number: '123')
mary = Patient.new(name: 'mary')
steve = Patient.new

p bob
p sally
p mary
p steve


beethoven = Room.new(name: 'Beethoven', capacity: 2)
p beethoven

puts "The #{beethoven.name} room has #{beethoven.patients.count} patients. Full? #{beethoven.full?}"
beethoven.add_patient(sally)
beethoven.add_patient(steve)
puts "The #{beethoven.name} room has #{beethoven.patients.count} patients. Full? #{beethoven.full?}"
puts "Sally is in #{sally.room.name} room"
puts "Steve is in #{steve.room.name} room"
# Will fail! Mary has no room
# puts "Mary is in #{mary.room.name} room"


# Let's try to add an extra patient to the full room...
begin
  beethoven.add_patient(bob)
  puts "The #{beethoven.name} room has #{beethoven.patients.count} patients. Full? #{beethoven.full?}"
rescue Room::CapacityReachedException
  puts "Sorry, couldn't add #{bob.name} to #{beethoven.name} room. The room is full"
rescue IOExcpetion
  puts "Something went wrong in our system"
end


puts steve.room.patients.first.room.patients.first.name
