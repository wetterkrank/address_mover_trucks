class Booking < ApplicationRecord
    validates :status, :start_date, :end_date, presence: true
end
