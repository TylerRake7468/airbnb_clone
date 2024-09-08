class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_one :payment, dependent: :destroy
  has_one :review, dependent: :destroy

  validates :checkin_date, presence: :true
  validates :checkout_date, presence: :true

  scope :upcoming_reservations, -> { where("checkin_date > ?", Date.today).order(:checkin_date)}
  scope :current_reservations, -> { where("checkin_date < ?",Date.today).where("checkout_date > ?", Date.today).order(:checkout_date)}

  scope :overlapping_reservations, ->(checkin_date, checkout_date){
    where(
      '(checkin_date < ? AND checkout_date > ?) OR
       (checkin_date < ? AND checkout_date > ?) OR
       (checkin_date > ? AND checkout_date < ?) OR
       (checkin_date < ? AND checkout_date > ?)',
       checkin_date, checkin_date,
      checkout_date, checkout_date,
      checkin_date, checkout_date,
      checkin_date, checkout_date
    )
  }

# TODO: 1. when we are going to show any property 
# by default checkin checkout date should be set to first available date.
# 2. and when we are creating reservation or payment we have to validate same date 
# checkin checkout should not be date there for same property


end
