require_relative 'journey'

class JourneyLog
  attr_reader :history
  attr_accessor :start

  def initialize(journey_class)
    @history = []
    @journey = Journey.new
  end

  def start(start_station)
    current_journey(start_station)
    @history << @journey
  end

  def finish(finish_station)
    @f = true
    current_journey(finish_station)
    @history.last.finish = finish_station
    @f = false
  end

  private

  def current_journey(station)
    if @history.empty? || @journey.complete? #Start an new journey under normal circumstances
      @journey = Journey.new(station)
    elsif @f && (@history.empty? || @journey.complete?) #Finish an invalid journey (no tounch in)
      @history << Journey.new(nil, station)
    elsif !@history.last.start.nil? && @history.last.finish.nil? #Finish an invalid journey (no touch out)
      @history << @journey
      @journey = Journey.new(station)
    elsif @history.last.finish.nil? #Finish a valid journey
      @journey
    end
  end

end
