module api
    class WishlistsController < ApplicationController
        def create
            wishlist = Wishlist.create!(wishlist_params)
            respond_to do |format|
                format.json do
                    render :wishlist, status: :ok
                end
            end
        end

        def destroy
            wishlist = Wishlist.find(params[:id])
            wishlist.destroy if wishlist.present?
            respond_to do |format|
                format.json do
                    render "", status: 204
                end
            end
        end

        private

        def wishlist_params
            params.permit(:user_id, :property_id)
        end
    end
end