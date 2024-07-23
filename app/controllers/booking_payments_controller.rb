class BookingPaymentsController < ApplicationController


    def create
        # raise
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

    def stripe_customer
        stripe_customer ||= if user.stripe_customer_id.nil?
            customer = Stripe::Customer.create({
                name: user&.name,
                email: user&.email,
            })
            user.update(stripe_customer_id: customer.id)
            customer
        else
            Stripe::Customer.retrieve(user.stripe_customer_id)
        end
    end

    def user
        user ||= User.find(id: booking_payments_params[:user_id])
    end

    def property
        property = Property.find(id: booking_payments_params[:property_id])
    end
end