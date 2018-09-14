require 'journey'

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#start' do
    it 'sets an entry_station variable ' do
      subject.start(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe '#end' do
    it 'ends the journey' do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject.entry_station).to eq(nil)
    end
  end

  describe '#fare' do
    it 'returns the journey cost at the end of the journey' do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end
  end
end
