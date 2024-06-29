class PropertiesController < ApplicationController
    def show
        @property = Property.includes(:reviews).find(params[:id])
        @overall_final_rating = @property.reviews.group('ROUND(final_rating)').count.transform_keys(&:to_i)
        @overall_final_rating.default = 0
    end
end