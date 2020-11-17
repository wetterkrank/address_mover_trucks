class Truck < ApplicationRecord
has_many :users

  validates :title, presence: true
  validates :title, length: { in: 5..100 }
  validates :location, presence: true
  validates :price_per_day, presence: true
  validates :size, presence: true
  validates :description, presence: true

end
