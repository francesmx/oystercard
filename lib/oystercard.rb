class Oystercard

  TOP_UP_LIMIT = 90

  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if balance + money > TOP_UP_LIMIT
    @balance += money
    "Your new balance is £#{balance}"
  end

  def deduct money
      @balance -= money
  end

  def in_journey_method
    @in_journey = !@injourney
  end

  def touch_in
    in_journey
  end

  def touch_out
    in_journey
  end

end
