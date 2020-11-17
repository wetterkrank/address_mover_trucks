class Booking < ApplicationRecord
    validates :status, :start_date, :end_date, presence: true

    belongs_to :user
    belongs_to :truck
end
