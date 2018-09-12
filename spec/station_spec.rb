require 'station'

describe Station do

  subject { described_class.new("King's Cross", 1) }

  describe '#zone' do
    it "should return the zone of the Station" do
      expect(subject.zone).to eq 1
    end
  end
  
  describe '#name' do
    it "should return the name of the Station" do
      expect(subject.name).to eq 'King\'s Cross'
    end
  end

end