# Details about the journey and history for Oystercard
class Journey
  attr_reader :entry_station, :journey_history

  def initialize(minimum_value)
    @journey_history = {}
    @MINIMUM_VALUE = minimum_value
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    @journey_history[entry_station] = exit_station
    @entry_station = nil
  end
end
