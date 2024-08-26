class EmailsController < ApplicationController
    before_action :authenticate_user!

    def edit
    end

    def update
        if current_user.update!(user_params)
            redirect_to edit_email_path, notice: "Email update successfully."
        else
            redirect_back fallback_location: edit_email_path, alert: "Failed to update Email"
        end
    end

    private

    def user_params
        params.require(:user).permit(:email)
    end
end