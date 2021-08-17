class Patient
  # State
  # - name
  # - id number
  # - problem
  # - room number
  # - treated?
  # - cured
  # Behavior
  # - discharge
  # - cure!

  attr_reader :name, :id_number
  attr_accessor :room, :id

  def initialize(attr = {})
    @name = attr[:name]
    @cured = attr[:cured] || false
    @id_number = attr[:id_number]
    @room = attr[:room]
    @id = attr[:id]
  end

  def cured?
    @cured
  end

  def cure!
    @cured = true
  end
end
