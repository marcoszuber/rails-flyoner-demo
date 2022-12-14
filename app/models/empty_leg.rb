class EmptyLeg < ApplicationRecord
    has_one :booking


    def price
        Booking.find_by_empty_leg_id(self.id).total_price
    end

    end
