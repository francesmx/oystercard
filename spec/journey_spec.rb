require 'journey'
require 'station'

describe Journey do

  penalty_fare = Journey::PENALTY_FARE
  minimum_fare = Journey::MINIMUM_FARE

  let(:station) {double(:station, name: 'Old Street', zone: 1)}
  let(:exit_station) { double(:station, name: 'New Street', zone: 2) }
  station1 = Station.new(:name1,1)
  station2 = Station.new(:name2,2)
  station3 = Station.new(:name3,3)
  station4 = Station.new(:name4,4)
  station5 = Station.new(:name5,5)


  describe '#initialize' do
    it 'defaults entry station to nil' do
      expect(subject.entry_station).to eq nil
    end
    it 'defaults entry station to nil' do
      expect(subject.exit_station).to eq nil
    end
  end

  describe '#complete?' do
    it 'knows journey is complete' do
      subject.entry_station = station1
      subject.exit_station = station2
      expect(subject).to be_complete
    end
    it 'knows journey is incomplete' do
      subject.entry_station = station
      expect(subject).not_to be_complete
    end
    it 'knows journey is incomplete' do
      subject.exit_station = station
      expect(subject).not_to be_complete
    end
  end

  describe '#charge' do
    it 'applies a penalty charge if the journey is incomplete' do
      expect(subject.charge).to eq penalty_fare
    end
    it 'applies the standard fare if the journey is complete' do
      subject.entry_station = station1
      subject.exit_station = station1
      expect(subject.charge).to eq minimum_fare
    end

    it 'charges 2 when crossing a zone' do
      subject.entry_station = station1
      subject.exit_station = station2
      expect(subject.charge).to eq 2
    end

    it 'charges 3 when crossing 2 zones' do
      subject.entry_station = station1
      subject.exit_station = station3
      expect(subject.charge).to eq 3
    end

    it 'charges 4 when crossing 3 zones' do
      subject.entry_station = station1
      subject.exit_station = station4
      expect(subject.charge).to eq 4
    end

    it 'charges 5 when crossing 4 zones' do
      subject.entry_station = station1
      subject.exit_station = station5
      expect(subject.charge).to eq 5
    end

  end

end
