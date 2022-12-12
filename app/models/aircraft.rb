class Aircraft < ApplicationRecord
  belongs_to :user
  has_many :bookings

  has_many_attached :photos
  after_create :update_status

  validates :name, presence: true
  validates :description, presence: true
  validates :seats, presence: true
  validates :price, presence: true

  private

  def update_status
    self.update_column(:status, true)
  end
end
