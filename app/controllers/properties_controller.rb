class PropertiesController < ApplicationController
    def show
        @property = Property.includes(:reviews).find(params[:id])
        @overall_final_rating = @property.reviews.group('ROUND(final_rating)').count.transform_keys(&:to_i)
        @overall_final_rating.default = 0

        @blocked_dates = @property.reservations.upcoming_reservations.pluck(:checkin_date, :checkout_date).map{|upr| [upr[0].to_s, (upr[1]-1.days).to_s]}
    end
end