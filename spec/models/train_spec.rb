require 'rails_helper'

RSpec.describe Train, type: :model do
  it "values which are valid" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.today, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, train_capacity: 60, seats_left: 40)
    expect(train).to be_valid
  end

  it "values are not valid when train number is negative" do
    train = Train.new(train_number: -168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.today, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, train_capacity: 60, seats_left: 40)
    expect(train).to_not be_valid
  end

  it "Not valid when there is a missing attribute - train capacity is not defined" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.today, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, seats_left: 40)
    expect(train).to_not be_valid
  end

  it "values not valid with a negative train price" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.today, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: -716, train_capacity: 60, seats_left: 40)
    expect(train).to_not be_valid
  end

  it "Not valid when the seats left is greater than the train capacity" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.today, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, train_capacity: 60, seats_left: 76)
    expect(train).to_not be_valid
  end

  it "Values are valid when the arrival and departure dates are the same" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.tomorrow, arrival_date: Date.tomorrow, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, train_capacity: 60, seats_left: 40)
    expect(train).to be_valid
  end

  it "Values are not valid when the departure date comes after the arrival date" do
    train = Train.new(train_number: 168, departure_station: "Raleigh", termination_station: "Durham",
                      departure_date: Date.tomorrow, arrival_date: Date.today, departure_time: Time.now,
                      arrival_time: Time.now + 1.hour, ticket_price: 716, train_capacity: 60, seats_left: 40)
    expect(train).to_not be_valid
  end
  end


