require 'journey'

describe Journey do

  describe '#initialize' do

    it 'has a default entry_station of nil' do
      expect(subject.start).to eq nil
    end

    it 'has a default exit_station of nil' do
      expect(subject.finish).to eq nil
    end
  end

  let(:card) { double(:oystercard, balance: 90) }

  describe '#complete?' do
    it 'returns true when complete journey' do
      subject.start = 'Station X'
      subject.finish = 'Station Y'
      expect(subject).to be_complete
    end
    it 'returns false when not touched out' do
      subject.start = 'Station X'
      expect(subject).not_to be_complete
    end
    it 'returns false when not touched in' do
      subject.finish = 'Station Y'
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    it 'charges minimum fare for a complete journey' do
      subject.start = 'Station X'
      subject.finish = 'Station Y'
      expect(subject.fare).to eq 1
    end
    it 'charges penalty fare when not touched out' do
      subject.start = 'Station X'
      expect(subject.fare).to eq 6
    end
    it 'charges penalty fare when not touched in' do
      subject.finish = 'Station Y'
      expect(subject.fare).to eq 6
    end
  end
end
