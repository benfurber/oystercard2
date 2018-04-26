require 'journey'

# The main Ostercard object
class Oystercard
  attr_reader :balance

  LIMIT = 90
  MINIMUM_VALUE = 1

  def initialize
    @balance = 0
    @journey = Journey.new(MINIMUM_VALUE)
  end

  def in_journey?
    @journey.in_journey?
  end

  def journey_history
    @journey.journey_history
  end

  def touch_in(entry_station)
    raise 'Minimum card balance required' if @balance < MINIMUM_VALUE
    @journey.touch_in(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_VALUE)
    @journey.touch_out(exit_station)
  end

  def top_up(value)
    raise "Maximum limit of £#{LIMIT} exceeded" if @balance + value > LIMIT
    @balance += value
  end

  private

  def deduct(value)
    raise 'Invalid amount' if value < 0
    @balance -= value
  end
end
