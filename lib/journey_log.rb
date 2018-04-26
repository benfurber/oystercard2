class Journeylog
  attr_reader :journey_history

  def initialize(journey_class = Journey)
    @journey_history = []
    @journey_class = journey_class
  end

  def start(entry_station)
    @journey_history << create_journey(entry_station)
  end

  def finish(exit_station)
    current_journey.add_exit_station(exit_station)
  end

  private

  def create_journey(entry_station)
    @journey_class.new(entry_station)
  end

  def current_journey
    @journey_history.last
  end
end
