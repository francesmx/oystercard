class Station

  attr_reader :name, :zone

  def initialize(name="Station Name", zone="Zone Number")
    @name = name
    @zone = zone
  end

end
