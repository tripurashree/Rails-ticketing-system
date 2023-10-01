class Review < ApplicationRecord
  validates :feedback, presence:true
  belongs_to :user
  belongs_to :train
end
