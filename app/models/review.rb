class Review < ApplicationRecord
  validates :feedback, presence:true
end
