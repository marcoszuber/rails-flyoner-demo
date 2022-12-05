class AddUserIdToReviewAircraft < ActiveRecord::Migration[7.0]
  def change
    add_reference :review_aircrafts, :user, index: true
  end
end
