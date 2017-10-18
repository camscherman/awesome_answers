class Admin::ApplicationController < ApplicationController
    # To generate this controller, we used the command 'rails g controller Admin::Application --no-assets --no-routes --no-helper
    # Because we prefixed the name of the controller with Admin, rails' generator created a directory named 'admin'  for the controller.
    # This controller is used as the parent controller for all other admin controllers.

    before_action :authenticate_user!
    before_action :authorize_admin!

    private

    def authorize_admin!
        redirect_to root_path alert: "Access denied!" unless current_user.is_admin?
    end
end
