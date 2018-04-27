# Details about the journey and history for Oystercard
class Journey
  attr_reader :entry_station, :exit_station, :fare

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def add_exit_station(exit_station = nil)
    @exit_station = exit_station
    set_complete
  end

  def complete?
    @complete
  end

  def fare
    @fare = !entry_station || !exit_station ? 6 : 1
  end

  private

  def set_complete
    @complete = true
  end

end
