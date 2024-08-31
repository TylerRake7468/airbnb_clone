module Owner
    class PropertiesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_property, only: [:edit, :update]

        def index
            @properties = current_user.properties
        end

        def new
        end

        def edit
        end

        def update
            if @property.update!(property_params)
                redirect_to edit_owner_property_path, notice: "property update successfully."
            else
                redirect_back fallback_location: edit_owner_property_path, alert: "Failed to update profile"
            end
        end

        private
        def set_property
            @property = current_user.properties.find(params[:id])
        end

        def property_params
            params.require(:property).permit(
                :name,
                :headline,
                :price,
                :description,
                :address_1,
                :address_2,
                :city,
                :state,
                :country_code
            )
        end
    end
end