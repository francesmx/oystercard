require 'station'

describe Station do

  describe "#initialize" do
    let(:subject) {described_class.new(:knightsbridge, 3)}
    it "should have a name" do
      expect(subject.name).to eq :knightsbridge
    end
    it "should have a zone number" do
      expect(subject.zone).to eq 3
    end
  end
end
 
