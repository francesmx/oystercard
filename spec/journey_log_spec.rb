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
    it 'starts a journey with a given destination' do
      subject.start("A")
      expect(subject.history.last.start).to eq "A"
    end
    it 'creates a new journey if you touch in twice' do
      subject.start("A")
      subject.start("B")
      expect(subject.history.last.start).to eq "B"
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }

    it 'should add information to an incomplete journey and not start a new one' do
      subject.start("A")
      subject.finish("B")
      expect(subject.history.count).to eq 1
    end
    it 'completes a journey with a given destination' do
      subject.start("A")
      subject.finish("B")
      expect(subject.history.last.finish).to eq "B"
    end
    it 'completes a journey with a given destination and retains origin' do
      subject.start("A")
      subject.finish("B")
      expect(subject.history.last.start).to eq "A"
    end
    it 'creates a new journey if you touch out twice' do
      subject.finish("A")
      subject.finish("B")
      expect(subject.history.last.finish).to eq "B"
    end
  end
end
