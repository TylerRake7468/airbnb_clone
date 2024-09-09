class AddPerNightPriceToPayment < ActiveRecord::Migration[7.1]
  def change
    add_monetize :payments, :per_night, amount: { null: true, default: nil }, currency: { null: true, default: nil }
  end
end
