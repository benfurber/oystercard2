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
    !@journey_history.last.complete?
  end

  def touch_in(entry_station)
    raise 'Minimum card balance required' if @balance < MINIMUM_VALUE
    create_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_VALUE)
    @journey_history.last.add_exit_station(exit_station)
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

  def create_journey(entry_station)
    @journey_history << Journey.new(entry_station)
  end
end
