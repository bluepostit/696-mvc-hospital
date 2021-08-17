class Room
  # State
  # - number
  # - capacity
  # - patients (array)

  # Behavior
  # - full?
  # - add patient
  # - remove patient

  class CapacityReachedException < Exception; end

  attr_reader :name, :patients
  attr_accessor :id

  def initialize(attr = {})
    @name = attr[:name]
    @capacity = attr[:capacity]
    @patients = attr[:patients] || []
    @id = attr[:id]
  end

  def add_patient(patient)
    if full?
      fail CapacityReachedException, "The #{@name} room is full"
    end

    @patients << patient
    # Record this connection on the PATIENT, too!
    patient.room = self
  end

  def full?
    @patients.length >= @capacity
  end

  # def remove_patient(patient)
  #   @patients.delete(patient)
  # end
end
