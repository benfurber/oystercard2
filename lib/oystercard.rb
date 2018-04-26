require 'journey'
require 'pry'
require 'pry-byebug'


# The main Ostercard object
class Oystercard
  attr_reader :balance, :journey_history

  LIMIT = 90
  MINIMUM_VALUE = 1

  def initialize
    @balance = 0
    @journey_history = []
    @in_journey = false
  end

  def in_journey?
    return false if @journey_history.empty?
    !current_journey.complete?
  end

  def touch_in(entry_station)
    touch_in_check
    raise 'Minimum card balance required' if @balance < MINIMUM_VALUE
    create_journey(entry_station)
  end

  def touch_out(exit_station)
    create_journey if !in_journey?
    current_journey.add_exit_station(exit_station)
    deduct(current_journey.fare)
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

  def create_journey(entry_station =nil)
    @journey_history << Journey.new(entry_station)
  end

  def current_journey
    @journey_history.last
  end

  def touch_in_check
    if current_journey && !current_journey.complete?
      current_journey.add_exit_station
      deduct(current_journey.fare)
    end
  end
end
