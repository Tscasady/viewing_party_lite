class AdminController < ApplicationController
  before_action :require_admin

   
  def require_admin
    redirect_to root_path and flash[:alert] = 'You do not have admin privileges.' unless current_user.admin?
  end
end
