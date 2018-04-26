# Details about the journey and history for Oystercard
class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def add_exit_station(exit_station)
    @exit_station = exit_station
    set_complete
  end

  def set_complete
    @complete = true
  end

  def complete?
    @complete
  end
end
