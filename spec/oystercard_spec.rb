require 'oystercard'
require 'journey'

describe Oystercard do

  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  let(:journey) { {start: entry_station, finish: exit_station} }

  context 'With max balance on card' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end

    it 'can not be topped up beyond limit' do
      message = "Beyond limit of #{described_class::MAXIMUM_BALANCE}"
      expect{subject.top_up(1)}.to raise_error message
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'new card not in_journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do

    it 'raises error when insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end

    it 'changes in_journey to true' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'allows you to touch in twice, and creates a new journey for the second touch in' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_in(double(:station))
      expect(subject.journey_history[-2].finish).to eq nil
    end

  end

  describe '#touch_out' do

    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it 'deducts the correct amount from card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Journey::MINIMUM_FARE)
    end

    it 'changes in_journey to false' do
      expect(subject).not_to be_in_journey
    end

    it 'allows you to touch in twice, and creates a new journey for the second touch in' do
      subject.touch_out(double(:station))
      expect(subject.journey_history[-1].start).to eq nil
    end

  end

  describe '#journey_history' do
    it 'returns entry and exit station' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include journey
    end
  end

  describe '#initialize' do
    it 'has empty list of journeys' do
      expect(subject.journey_history).to be_empty
    end

    it 'balance is zero' do
      expect(subject.balance).to eq(0)
    end

  end

end
