require 'journey'

describe Journey do

  describe '#initialize' do

    it 'has a default entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'has a default exit_station of nil' do
      expect(subject.exit_station).to eq nil
    end
  end

  let(:card) { double(:oystercard, balance: 90) }

  describe '#complete?' do
    it 'returns true when complete journey' do
      subject.entry_station = 'Station X'
      subject.exit_station = 'Station Y'
      expect(subject).to be_complete 
    end
    it 'returns false when not touched out' do
      subject.entry_station = 'Station X'
      expect(subject).not_to be_complete
    end
    it 'returns false when not touched in' do
      subject.exit_station = 'Station Y'
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    # it 'charges minimum fare for a valid journey' do
      
    #   expect()
    # end
  end
end
