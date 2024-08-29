module Owner
    class PropertiesController < ApplicationController
        before_action :authenticate_user!
        def index
            @properties = current_user.properties
        end

        def new
        end

        def edit
        end
    end
end