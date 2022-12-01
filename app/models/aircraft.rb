class Aircraft < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :bookings
  
  has_many_attached :photos
end
