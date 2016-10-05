class Journey

  attr_accessor :start, :finish

  # def initialize(entry_station, exit_station)
  #   @start = entry_station
  #   @finish = exit_station
  # end

  def complete?
    !start.nil? && !finish.nil?
  end

end
