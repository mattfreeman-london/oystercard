class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journey_history
  attr_reader :journey

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def top_up(credit)
    new_balance = @balance += credit
    raise "Maximum balance is £#{BALANCE_LIMIT}." if new_balance > BALANCE_LIMIT

    @balance = new_balance
  end

  def in_journey?
    return false if @entry_station == nil
    return true
  end

  def touch_in(entry_station)
    raise "Below £#{MINIMUM_BALANCE}." if @balance <= MINIMUM_BALANCE

    @entry_station = entry_station
    @journey = {}
    @journey[:entry] = entry_station
  end

  def touch_out(exit_station)
    @balance -= 1
    @entry_station = nil
    @exit_station = exit_station
    @journey[:exit] = exit_station
    @journey_history << @journey
  end

private

  def deduct(debit)
    @balance -= debit
  end

end
