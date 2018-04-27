require_relative 'journey.rb'

class Journeylog
  attr_reader :journey_history, :current

  def initialize(journey_class = Journey)
    @journey_history = []
    @journey_class = journey_class
  end

  def start(entry_station)
    @current = create_journey(entry_station)
    @journey_history << @current
  end

  def finish(exit_station)
    current_journey
    @current.add_exit_station(exit_station)

  end

  def complete?
    !@journey_history.empty? && !current.complete?
  end

  def fare
    @current.fare
  end

  private

  def current_journey
    @current ||= create_journey
  end

  def create_journey(entry_station = nil)
    @journey_class.new(entry_station)
  end
end
