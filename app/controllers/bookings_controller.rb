class BookingsController < ApplicationController
    def new
        @property = Property.find(booking_params[:property_id])
        @checkin_date = Date.parse(booking_params[:checkinDate])
        @checkout_date = Date.parse(booking_params[:checkoutDate])
        @total_nights = numberOfNights
        @base_fare = @property.price *  @total_nights
        @service_fee = @base_fare * 0.18
        @total_amount = @base_fare + @service_fee
    end

    def numberOfNights
        return (@checkout_date - @checkin_date).to_i
    end

    private

    def booking_params
        params.permit(:property_id, :checkinDate, :checkoutDate)
    end
end