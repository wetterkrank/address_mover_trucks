class Truck < ApplicationRecord
  belongs_to :user
  has_many :users, through: :bookings
  has_many :bookings
  has_many_attached :photos
 
  
  SIZE = ["Small", "Medium", "Large", "X-Large"]
  validates :title, presence: true
  validates :title, length: { in: 5..100 }
  validates :location, presence: true
  validates :price_per_day, presence: true
  validates :size, presence: true
  validates :description, presence: true
  validates :size, inclusion: { in: SIZE, message: "Not a valid category" }

  include PgSearch::Model
  pg_search_scope :search_by_truck_attributes,
    against: [:title, :size, :location, :price_per_day],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?


end
