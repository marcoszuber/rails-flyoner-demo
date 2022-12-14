class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :aircraft
  has_one :empty_leg, dependent: :destroy
  has_one :review_aircraft, dependent: :destroy
  has_one :payment, dependent: :destroy
  validates :start_time, presence: true
  validates :finish_time, presence: true


  validates_comparison_of :finish_time, greater_than_or_equal_to: :start_time, message: "Ups, some went wrong! check the form and if the airplane isn't booked"
  validate :validate_other_booking_overlap

  def period
    start_time..finish_time
  end

  def add_empty_leg

    empty_leg = EmptyLeg.new
    empty_leg.from = Airport.find(self.to).country
    empty_leg.to = Airport.find(self.from).country
    empty_leg.date = self.finish_time
    empty_leg.seat_available = self.aircraft.seats
    empty_leg.save
    self.empty_leg_id = empty_leg.id
    self.save
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
