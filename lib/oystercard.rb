class Oystercard

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @in_journey = false
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

  def touch_in(station)
    raise "Below £#{MINIMUM_BALANCE}." if @balance <= MINIMUM_BALANCE

    @entry_station = station
  end

  def touch_out
    @balance -= 1
    @entry_station = nil
  end

private

  def deduct(debit)
    @balance -= debit
  end

end
