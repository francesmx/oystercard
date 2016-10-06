require_relative 'station'
require_relative 'journey_log'

class Oystercard

  TOP_UP_LIMIT = 90
  MINIMUM_BALANCE = 1

  attr_reader :balance, :list_journeys

  def initialize
    @balance = 0
    @list_journeys = JourneyLog.new
    puts "In initialize, @list_journeys = #{@list_journeys}"
  end

  def top_up money
    fail "Top-up limit of £#{TOP_UP_LIMIT} exceeded." if over_limit?(money)
    @balance += money
    "Your new balance is £#{balance}"
  end

  def touch_in(station)
    check_balance
    if !@list_journeys.current_journey.nil?
      deduct if !@list_journeys.current_journey.complete?
    end
    @list_journeys.start(station)
  end

  def touch_out(station)
# If the previous journey wasn't complete. deduct penalty fare
    # if !@list_journeys.journeys.last.nil? && @list_journeys.journeys.last.exit_station.nil?
    #   deduct
    # end
    # if @list_journeys.journeys.last.nil? && @list_journeys.journeys.last.complete?
    # end
    @list_journeys.finish(station)
    deduct
  end

  def list_journeys
    @list_journeys.journeys
  end

private

  def check_balance
    fail "Card empty - £#{MINIMUM_BALANCE} required" if empty?
  end

  def deduct
    @balance -= @list_journeys.journeys.last.charge
    "Your new balance is £#{@balance}"
  end

  def empty?
    balance < MINIMUM_BALANCE
  end

  def over_limit? money
    balance + money > TOP_UP_LIMIT
  end

end


# def touch_out(station)
#   @list_journeys.finish(station)
#   if @list_journeys.current_journey.entry_station.nil?
#     if !@list_journeys.journeys[-2].complete?
#       deduct
#     elsif @list_journeys.count == 1
#       deduct
#     end
#   end
#   deduct
# end
