class Oystercard
  attr_reader :balance

  LIMIT = 90
  MINIMUM_VALUE = 1

  def initialize
    @balance = 0
  end

  def top_up(value)
    raise "Maximum limit of £#{LIMIT} exceeded" if @balance + value > LIMIT
    @balance += value
  end

  private

  def deduct(value)
    raise "Invalid amount" if value < 0
    @balance -= value
  end
end
