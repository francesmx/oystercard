require 'journey_log'

describe JourneyLog do

  let(:station1) {double(:station, name: 'Old Street', zone: 1)}
  let(:station2) {double(:station, name: 'Turnham Green', zone: 2)}
  let(:station5) {double(:station, name: 'Twickenham', zone: 5)}

  describe '#initialize' do
    it 'defaults to an empty array' do
      expect(subject.journeys.count).to eq 0
    end
  end

  describe "#start" do
    it 'adds something to the journeys array' do
      subject.start(station1)
      expect(subject.journeys.count).to eq 1
    end
    it 'records the entry station in current_journey' do
      subject.start(station1)
      expect(subject.current_journey.entry_station).to eq station1
    end
    it 'puts a journey object into current_journey' do
      subject.start(station1)
      expect(subject.current_journey).to be_an_instance_of Journey
    end
    it "creates two journey entries for a double touch in" do
      subject.start(station1)
      subject.start(station1)
      expect(subject.journeys.count).to eq 2
    end
  end

  describe "#finish" do
    it 'records the exit station in the journeys array' do
      subject.start(station2)
      subject.finish(station5)
      expect(subject.journeys.last.exit_station).to eq station5
    end
    it "creates two journey entries for a double touch out" do
      subject.finish(station2)
      subject.finish(station2)
      expect(subject.journeys.count).to eq 2
    end
    it "create a journey even if only touching out" do
      subject.finish(station1)
      expect(subject.journeys.count).to eq 1
    end
  end

  describe "#journeys" do
    it 'puts a journey object into the journeys array' do
      subject.start(station1)
      subject.finish(station2)
      expect(subject.journeys).to include Journey
    end
  end
end
