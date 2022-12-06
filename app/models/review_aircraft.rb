class ReviewAircraft < ApplicationRecord
  belongs_to :aircraft
  belongs_to :user
  has_one :booking

  #validates :stars, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  #validates :description, presence: true
end
