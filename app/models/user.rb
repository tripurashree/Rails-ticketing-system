class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews, dependent: :destroy
  has_many :tickets, dependent: :destroy
  # validates :credit_card_info, presence:true, length: {minimum: 16, maximum:16}
  # validates :phone_number, format: { with: /\A(?:\+?\d{1,3}[-.\s]?)?\(?\d{1,}\)?[-.\s]?\d{1,}[-.\s]?\d{1,}\z/, message: "is not a valid phone number" }
end
