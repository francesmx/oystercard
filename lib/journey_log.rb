require_relative 'journey'

class JourneyLog
  attr_reader :history
  attr_accessor :start

  def initialize(journey_class)
    @history = []
  end

  def start(station)
    current_journey(station)
    @history << @journey
  end

  def finish(station)
    @f = true
    current_journey(station)
    @history.last.finish = station
    @f = false
  end

  private

  def current_journey(station)
    if !@history.empty? && @history.last.finish.nil?
      @journey
    elsif @f && (@history.empty? || @journey.complete?)
      @journey = Journey.new(nil, station)
      @history << @journey
    elsif @history.empty? || @journey.complete?
      @journey = Journey.new(station)
    end
  end

end
