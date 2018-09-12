In order to use public transport
As a customer
I want money on my card

# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.balance

In order to keep using public transport
As a customer
I want to add money to my card

# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.balance
card.top_up(10)
card.balance

In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(100)
card.balance

In order to pay for my journey
As a customer
I need my fare deducted from my card

# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.top_up(50)
card.deduct(5)

In order to get through the barriers.
As a customer
I need to touch in and out.
# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.touch_in
card.touch_out
card.in_journey?

In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.
# irb
require './lib/oystercard.rb'
card = Oystercard.new
card.touch_in

In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card
# irb
require './lib/oystercard.rb'
minimum_fare = 2
card = Oystercard.new
card.top_up(10)
card.touch_in
card.touch_out
card.balance == 10 - minimum_fare

In order to pay for my journey
As a customer
I need to know where I've travelled from
# irb
require './lib/oystercard.rb'
card = Oystercard.new
station = ''
card.top_up(10)
card.touch_in(station)
card.entry_station == station

In order to know where I have been
As a customer
I want to see all my previous trips
# irb
require './lib/oystercard.rb'
card = Oystercard.new
charring_cross = Station.new
kings_cross = Station.new
card.top_up(10)
card.touch_in(kings_cross)
card.entry_station == kings_cross
card.touch_out(charring_cross)
card.journey_history

In order to know how far I have travelled
As a customer
I want to know what zone a station is in
# irb
require './lib/oystercard.rb'
require './lib/station.rb'
card = Oystercard.new
card.top_up(10)
station = Station.new('charing_cross', 1)
card.entry_station
card.touch_in(station)
card.entry_station