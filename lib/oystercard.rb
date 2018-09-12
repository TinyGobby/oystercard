class Oystercard

  attr_reader :balance, :journey_history
  
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize

    @balance = 0
    @journey_history = []

  end

  def top_up(value)

    fail "Value exceeds maximum allowed: #{MAXIMUM_BALANCE}" if value + @balance > MAXIMUM_BALANCE
    @balance += value
    
  end

  def touch_in(station)

    fail "Balance too low" if @balance < MINIMUM_BALANCE

    @journey_history.push({entry_station: station })

  end

  def touch_out(station)

    deduct(MINIMUM_FARE)

    @journey_history[-1][:exit_station] = station

  end

  def in_journey?
    !@journey_history[-1].has_key?(:exit_station)
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
