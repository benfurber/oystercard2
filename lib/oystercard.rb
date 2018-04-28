require_relative 'journey_log.rb'
require 'pry'
require 'pry-byebug'

# The main Ostercard object
class Oystercard
  attr_reader :balance, :journey_log

  LIMIT = 90
  MINIMUM_VALUE = 1

  def initialize(log_type = Journeylog)
    @balance = 0
    @journey_log = log_type.new
    @in_journey = false
  end

  def in_journey?
    return false if @journey_log.journey_history.empty?
    @journey_log.complete?
  end

  def touch_in(entry_station)
    touch_in_check
    raise 'Minimum card balance required' if @balance < MINIMUM_VALUE
    create_journey(entry_station)
  end

  def touch_out(exit_station)
    create_journey if !in_journey?
    journey_log.finish(exit_station)
    deduct(@journey_log.fare)
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

  def create_journey(entry_station = nil)
    @journey_log.start(entry_station)
  end

  def touch_in_check
    if @journey_log.complete?
      deduct(@journey_log.fare)
    end
  end
end
