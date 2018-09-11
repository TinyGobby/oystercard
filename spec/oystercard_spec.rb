require 'oystercard'

describe Oystercard do

let(:station) {instance_double("Station", :name => 'ABC', :zone => 1)}


  describe "#balance" do
    
    it 'returns an initial @balance of 0' do
      expect(subject.balance).to eq(0)
    end

  end

  describe "#top_up" do

    it 'updates the balance when passed a value' do
      value = rand(1..50)
      expect{subject.top_up(value)}.to change{subject.balance}.by(value)
    end

    it 'fails if @balance will go over MAXIMUM_BALANCE' do
      value = Oystercard::MAXIMUM_BALANCE + 1
      expect{subject.top_up(value)}.to raise_error("Value exceeds maximum allowed: #{Oystercard::MAXIMUM_BALANCE}")
    end

  end

  describe '#touch_in' do
    
    it "says your journey has started" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'raises error when @balance is below MINIMUM_BALANCE' do
      expect { subject.touch_in(station) }.to raise_error('Balance too low')
    end

    it 'sets the starting station' do
      # entry_station = double(:station => "zone1")
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
    
  end

  describe '#touch_out(station)' do

    it "says your journey has finished" do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to eq(false)
    end

    it "deducts journey fare from @balance" do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect { subject.touch_out(station) }.to change{ subject.balance }.by -(Oystercard::MINIMUM_FARE)
    end

    it 'adds @entry_station and end_station to @journey_history' do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      s1 = station #"Barbican-station"
      subject.touch_in(s1)
      s2 = station #"Wimbledon_station"
      subject.touch_out(s2)
      expect(subject.journey_history).to eq([{
        entry_station: s1, 
        exit_station: s2
      }])
    end

  end

  describe '#in_journey?' do

    it 'shows whether a card is in journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'shows whether a card is in journey' do
      subject.top_up(Oystercard::MINIMUM_BALANCE)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

  end

end