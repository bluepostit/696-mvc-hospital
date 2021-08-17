require 'csv'
require_relative 'patient'

class PatientRepository
  # State
  # - patients
  # - next_id

  # Behavior
  # - add
  # - remove
  # - get all

  def initialize(csv_file_path, room_repository)
    @csv_file_path = csv_file_path
    @room_repository = room_repository
    @next_id = 1
    @patients = []
    load_csv
  end

  def add_patient(patient)
    # Assign id to the patient
    patient.id = @next_id
    # Increment the @next_id! so that next patient added gets a new id
    @next_id += 1
    @patients << patient
    store_csv
  end

  def all
    @patients
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # Each row is like a hash! Because of the first row (headers)

      row[:cured] = row[:cured] == 'true'
      row[:id] = row[:id].to_i

      # Find the room! using the RoomRepository instance
      room_id = row[:room_id].to_i
      room = @room_repository.find(room_id)
      row[:room] = room

      patient = Patient.new(row)
      room.add_patient(patient) unless room.nil?
      @patients << patient
    end
    @next_id = @patients.last.id + 1 unless @patients.empty?
  end

  def store_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id name id_number room_id cured]
      @patients.each do |patient|
        csv << [patient.id, patient.name,
                patient.id_number, patient.room.id,
                patient.cured?]
      end
    end
  end
end
