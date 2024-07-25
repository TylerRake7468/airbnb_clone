class BookingPaymentsController < ApplicationController
    
    
    def create
        @property = Property.find(booking_payments_params[:property_id])
        stripe_price = Stripe::Price.create({
            currency: 'usd',
            unit_amount: Money.from_amount(BigDecimal(booking_payments_params[:total_amount])).cents,
            product_data: {name: @property.name},
        })
        success_url = url_for(controller: 'booking_payments', action: 'success', only_path: false)

        stripe_session = Stripe::Checkout::Session.create({
            success_url: success_url,
            line_items: [
                {
                price: stripe_price.try(:id),
                quantity: 1,
                },
            ],
            mode: 'payment',
        })

        redirect_to stripe_session&.url, allow_other_host: true, status: 303
    end


    def success
        # add reservation
        # create a success page
    end

    private

    def booking_payments_params
        params.permit(
            :user_id,
            :property_id,
            :checkin_date,
            :checkout_date,
            :base_fare,
            :service_fee,
            :total_amount,
            :stripToken,
        )
    end

end