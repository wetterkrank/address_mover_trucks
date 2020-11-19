class Booking < ApplicationRecord
    STATUS = [ "pending", "confirmed", "declined" ]

    validates :status, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: STATUS, message: "Not a valid booking status" }

    belongs_to :user
    belongs_to :truck
end
