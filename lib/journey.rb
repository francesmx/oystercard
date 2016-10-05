class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :start, :finish

  # def initialize(entry_station, exit_station)
  #   @start = entry_station
  #   @finish = exit_station
  # end

  def complete?
    !start.nil? && !finish.nil?
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
