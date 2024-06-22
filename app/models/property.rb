class Property < ApplicationRecord
    validates :name, presence: :true
    validates :description, presence: :true
    validates :headline, presence: :true
    validates :address_1, presence: :true
    validates :city, presence: :true
    validates :state, presence: :true
    validates :country, presence: :true

    monetize :price_cents, allow_nil: true

    has_many_attached :images
    has_many :reviews, dependent: :destroy
    has_many :wishlists, dependent: :destroy
    has_many :wishlisted_users, through: :wishlists, source: :user, dependent: :destroy
    has_many :reservations, dependent: :destroy
    has_many :reserved_users, through: :reservations, source: :user, dependent: :destroy

    def update_final_averate_rating
        avg_rating = reviews.average(:final_rating).to_f
        update_column(:average_final_rating, avg_rating)
    end

    def wishlisted_by(user=nil)
        return unless user.present?
        wishlisted_users.include?(user)
    end

    def available_dates
        next_reservation = reservations.upcoming_reservations.first
        current_reservation = reservations.current_reservations.first

        if current_reservation.nil? && next_reservation.nil?
            Date.tomorrow.strftime('%e %b')..(Date.tomorrow + 30.days).strftime('%e %b')
        elsif current_reservation.nil?
            Date.tomorrow.strftime('%e %b')..(next_reservation.checkin_date).strftime('%e %b')
        elsif next_reservation.nil?
            current_reservation.checkout_date.strftime('%e %b')..(current_reservation.checkout_date+30.days).strftime('%e %b')
        else
            current_reservation.checkout_date.strftime('%e %b')..(next_reservation.checkin_date+30.days).strftime('%e %b')
        end
    end
end
