class Aircraft < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings

  has_one_attached :photo
end
