require 'journey_log'

describe JourneyLog do

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) { double :journey }
  let(:journey_class){double :journey_class, new: journey}

  describe '#initialize'

  describe "#start" do

    it 'puts something in the journeys array' do
      subject.start(entry_station)
      expect(subject.journeys.count).to eq 1
    end

    it 'puts an actual journey in the journeys array' do
      subject.start(entry_station)
      expect(subject.current_journey.entry_station).to eq entry_station
    end

    it "creates separate journey entries for double touch ins" do
      subject.start(entry_station)
      subject.start(entry_station)
      expect(subject.journeys.count).to eq 2
    end

  end

  describe "#finish" do

    it 'adds an exit station to the current journey' do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.journeys.last.exit_station).to eq exit_station
    end

    it "creates separate journey entries for double touch outs" do
      subject.finish(exit_station)
      subject.finish(exit_station)
      expect(subject.journeys.count).to eq 2
    end

    it "allows a journey to be created if only touching out" do
      subject.finish(exit_station)
      expect(subject.journeys.count).to eq 1
    end

  end

end
