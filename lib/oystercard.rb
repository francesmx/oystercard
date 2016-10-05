
require_relative 'journey'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    if @journeys.empty?
      false
    else
      !@journey.complete?
    end
  end

  def touch_in(entry_station)
    touch_in_check
    @journey = Journey.new(entry_station)
    @journeys << @journey
  end

  def touch_out(exit_station)
    touch_out_check(exit_station)
    @journey.finish = exit_station
    deduct
  end

  def journey_history
    @journeys
  end

  private

  def deduct
    @balance -= @journey.fare
  end

  def touch_in_check
    fail 'Insufficient balance' if balance < Journey::MINIMUM_FARE
    deduct if in_journey?
  end

  def touch_out_check(exit_station)
    if !in_journey?
      @journey = Journey.new(nil,exit_station)
      deduct
    end
  end
end
