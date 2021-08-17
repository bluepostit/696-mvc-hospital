require_relative 'patient_repository'
require_relative 'room_repository'

room_repo = RoomRepository.new('rooms.csv')
# p room_repo

patient_repo = PatientRepository.new('patients.csv', room_repo)
# p patient_repo

patient_repo.all.each do |patient|
  puts "#{patient.name} (#{patient.id}) is in room #{patient.room.name}"
  # p patient.room
end


# Add a new patient
mike = Patient.new(name: 'mike', id_number: '8764')
mike.room = room_repo.find(2)
p mike
patient_repo.add_patient(mike)
