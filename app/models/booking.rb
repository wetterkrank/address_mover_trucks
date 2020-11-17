class Booking < ApplicationRecord
belongs_to :user
belongs_to :truck
        
validates :status, :start_date, :end_date, presence: true
end
