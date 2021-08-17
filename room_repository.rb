require 'csv'
require_relative 'room'

class RoomRepository
  # State
  # - rooms

  # Behavior
  # - add
  # - remove
  # - get all
  # - find (by id)! => returns the Room instance with that id.

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @rooms = []
    load_csv
  end

  def add_room(room)
    @rooms << room
  end

  def find(id)
    @rooms.find { |room| room.id == id }
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # Each row is like a hash! Because of the first row (headers)

      row[:id] = row[:id].to_i
      row[:capacity] = row[:capacity].to_i
      room = Room.new(row)
      @rooms << room
    end
  end
end
