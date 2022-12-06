class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :aircraft
  has_one :empty_leg, dependent: :destroy
  has_one :review_aircraft, dependent: :destroy
  has_one :payment, dependent: :destroy
  validates :start_time, presence: true
  validates :finish_time, presence: true

  validates_comparison_of :finish_time, greater_than: :start_time, message: "Ups, some went wrong! check the form and if the airplane isn't booked"
  validate :validate_other_booking_overlap

  def period
    start_time..finish_time
  end

  private

  def validate_other_booking_overlap
    other_bookings = Booking.where(aircraft_id: aircraft_id).where.not(id: id)
    is_overlapping = other_bookings.any? do |other_booking|
      period.overlaps?(other_booking.period)
    end
    errors.add(:overlaps_with_other, ", check the form and if the airplane isn't booked") if is_overlapping
  end
end
