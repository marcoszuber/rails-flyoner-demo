class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :aircraft

  validates :start_time, presence: true
  validates :finish_time, presence: true

  validates_comparison_of :finish_time, greater_than: :start_time, message: "Fecha de llegada debe ser mayor a la de salida"
end
