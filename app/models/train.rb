class Train < ApplicationRecord
  validates :train_number, presence:true, uniqueness:true
  validates :departure_station, presence:true
  validates :termination_station, presence:true
  validates :departure_date, presence:true
  validates :departure_time, presence:true
  validates :arrival_date, presence:true
  validates :arrival_time, presence:true
  validates :ticket_price, presence:true
  validates :train_capacity, presence:true

  has_many :reviews
  has_many :tickets
end
