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
  end

  private

  def current_journey(station)
    if !@history.empty? && !@history.last.finish.nil?
      @journey
    else
        @journey = Journey.new(station)
    end
  end

end
