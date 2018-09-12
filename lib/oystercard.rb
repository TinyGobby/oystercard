require_relative 'journey'
require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_history, :journey_handler
  
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize

    @balance = 0
    @journey_history = []
    @journey_handler = JourneyHandler.new

  end

  def top_up(value)

    fail "Value exceeds maximum allowed: #{MAXIMUM_BALANCE}" if value + @balance > MAXIMUM_BALANCE
    @balance += value
    
  end

  def touch_in(station)

    fail "Balance too low" if @balance < MINIMUM_BALANCE
    journey_handler.start(station)
    deduct(journey_handler.fare)
    
  end

  def touch_out(station)

    journey_handler.end(station) 
    @journey_history.push(journey_handler.journey)
    deduct(journey_handler.fare)

  end

  def in_journey?
    journey_handler.entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
