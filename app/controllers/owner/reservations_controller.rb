module Owner
    class ReservationsController < ApplicationController
        before_action :authenticate_user!
        def index
            @reservations = current_user.properties.map(&:reservations).flatten
        end
    end
end