module Owner
    class DashboardController < ApplicationController
        before_action :authenticate_user!
        def index
            @reservations = []
        end
    end
end