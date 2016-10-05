require 'journey_log'

describe JourneyLog do

  describe '#initialize' do
    it 'accepts one parameter' do
      expect(subject).to respond_to(:initialize).with(1).argument
    end
  end
  
  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }
  end
end