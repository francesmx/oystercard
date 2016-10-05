require 'journey_log'

describe JourneyLog do

  subject do
    JourneyLog.new("journey_class")
  end

  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'should start a new journey with an entry station' do
      subject.start("A")
      expect(subject.history.count).to eq 1
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }
  end
end
