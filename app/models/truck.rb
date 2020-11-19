class Truck < ApplicationRecord
belongs_to :user
has_many :users, through: :bookings
has_many :bookings
has_many_attached :photos

  validates :title, presence: true
  validates :title, length: { in: 5..100 }
  validates :location, presence: true
  validates :price_per_day, presence: true
  validates :size, presence: true
  validates :description, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
