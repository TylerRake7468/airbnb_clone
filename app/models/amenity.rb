class Amenity < ApplicationRecord
    validates :name, presence: :true
    validates :icon, presence: :true
    

    has_many :property_amenities, dependent: :destroy
    has_many :properties, through: :property_amenities, source: :property, dependent: :destroy
end