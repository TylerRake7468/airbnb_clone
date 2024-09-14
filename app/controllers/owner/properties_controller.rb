module Owner
    class PropertiesController < ApplicationController
        before_action :authenticate_user!
        before_action :set_property, only: [:edit, :update, :update_amenities, :remove_image, :add_images, :destroy, :update_location]

        def index
            @properties = current_user.properties.order(created_at: :desc)
        end

        def new
            @property = Property.new
        end

        def create
            @property = current_user.properties.create!(property_params)
            redirect_to edit_owner_property_path(@property), notice: "Property Created Successfully."
        end

        def edit
            @google_api_key = Rails.application.config.google_api_key["map_api_key"]
        end

        def update
            if @property.update!(property_params)
                redirect_to edit_owner_property_path, notice: "property update successfully."
            else
                redirect_back fallback_location: edit_owner_property_path, alert: "Failed to update profile"
            end
        end

        def update_amenities
            if @property.update!(amenities_params)
                redirect_to edit_owner_property_path, notice: "Amenities update successfully."
            else
                redirect_back fallback_location: edit_owner_property_path, alert: "Failed to update amenities"
            end
        end

        def destroy
            @property.destroy
            redirect_to owner_properties_path, alert: "#{@property.name} deleted successfully."
        end

        def add_images
            @property.images.attach(params[:property][:images].reject(&:blank?))
            redirect_to edit_owner_property_path, notice: "Property images uploaded successfully temp"
        end

        def remove_image
            image = @property.images.find(params[:image_id])
            if image.destroy!
                redirect_to edit_owner_property_path, notice: "Image removed successfully."
            else
                redirect_back fallback_location: edit_owner_property_path, alert: "Failed to update amenities"
            end
        end

        def update_location
            if @property.update!(location_params)
                redirect_to edit_owner_property_path, notice: "Location update successfully."
            else
                redirect_back fallback_location: edit_owner_property_path, alert: "Failed to update location"
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
                :country_code,
                :guest_count,
                :bedroom_count,
                :bed_count,
                :bathroom_count,
            )
        end

        def amenities_params
            params.require(:property).permit(:amenity_ids => [])
        end

        def location_params
            params.require(:property).permit(:lat, :lng)
        end
    end
end