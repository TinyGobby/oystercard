class Oystercard

  attr_reader :balance, :entry_station, :journey_history
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_history = []
  end

  def top_up(value)
    fail "Value exceeds maximum allowed: #{MAXIMUM_BALANCE}" if value + @balance > MAXIMUM_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Balance too low" if @balance < MINIMUM_BALANCE
    @entry_station = station
    @journey_history.push({entry_station: station })
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journey_history[-1][:exit_station] = station
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end
