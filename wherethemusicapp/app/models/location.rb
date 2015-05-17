class Location < ActiveRecord::Base
  validates :name, :address, presence: true

  geocoded_by :address
  after_validation :geocode

  scope :by_name, ->(query) { where('name LIKE ?', "%#{query}%") }
  scope :by_address, ->(query) { where('address LIKE ?', "%#{query}%") }
end
