
require './lib/oystercard'
require './lib/station'

describe Oystercard do

  subject(:oystercard) {described_class.new}
  let (:station) {double(:station)}
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {double :journey, entry_station: :exit_station}

  station1 = Station.new(:name1,1)
  station2 = Station.new(:name2,2)

  describe "#initialize" do
    it "has an initial balance of 0" do
      expect(subject.balance).to eq 0
    end
    it "list_journeys defaults to empty array" do
      expect(subject.list_journeys).to eq []
    end
  end

  describe "#top_up" do
    it "can top up the balance" do
      expect {subject.top_up 10 }.to change{ subject.balance }.by 10
    end
    it "has a top_up limit" do
      expect(Oystercard::TOP_UP_LIMIT.class).to be Fixnum
    end
    it "fails if you try to exceed top-up limit" do
      maximum_balance = Oystercard::TOP_UP_LIMIT
      subject.top_up(maximum_balance)
      expect{subject.top_up 1}.to raise_error "Top-up limit of £#{maximum_balance} exceeded."
    end
  end

  context "when topped up" do
    describe "#touch_in" do
      before(:each) do
        subject.top_up(Oystercard::TOP_UP_LIMIT)
      end
      it "should remember the entry station" do
        subject.touch_in(station)
        expect(subject.list_journeys.last.entry_station).to eq station
      end
      it "should deduct a penalty fare if touching in twice" do
        subject.touch_in(station)
        expect{subject.touch_in(station)}.to change{subject.balance}.by (-Journey::PENALTY_FARE)
      end
    end

    describe "#touch_out" do
      before(:each) do
        subject.top_up(Oystercard::TOP_UP_LIMIT)
      end

      it "should deduct the standard fare for a completed journey" do
        subject.touch_in(station1)
        expect{subject.touch_out(station1)}.to change{subject.balance}.by (-Journey::MINIMUM_FARE)
      end
      it "should deduct a penalty fare if touching out for the first time" do
        subject.touch_out(station)
        expect{subject.touch_out(station)}.to change{subject.balance}.by (-Journey::PENALTY_FARE)
      end
      it "should deduct a penalty fare if touching out twice" do
        subject.touch_in(station1)
        subject.touch_out(station1)
        expect{subject.touch_out(station1)}.to change{subject.balance}.by (-Journey::PENALTY_FARE)
      end
    end
  end

  it { is_expected.to respond_to :list_journeys }

  describe "#list_journeys" do

    before do
      subject.top_up(Oystercard::TOP_UP_LIMIT)
      subject.touch_in(station1)
      subject.touch_out(station2)
    end

    it "list_journeys stores the entry station" do
      expect(subject.list_journeys.last.entry_station).to eq station1
    end
    it "list_journeys stores the exit station" do
      expect(subject.list_journeys.last.exit_station).to eq station2
    end
  end

  context "when not topped up" do
    describe "#touch_in" do
      it "fails if balance is insufficient" do
        minimum_balance = Oystercard::MINIMUM_BALANCE
        expect{subject.touch_in(station)}.to raise_error "Card empty - £#{minimum_balance} required"
      end
    end
  end

end
