class ReviewAircraft < ApplicationRecord
  belongs_to :aircraft
  belongs_to :user
  has_one :booking
end
