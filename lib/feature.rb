require 'pry'
require_relative 'oystercard.rb'
require_relative 'station.rb'


card = Oystercard.new
station = Station.new("bank", 2)
station2 = Station.new("angel", 2)
binding.pry
card.touch_in(station1)
