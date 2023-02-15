module Admins
  class UsersController < AdminController
    def show
      @user = User.find(params[:id])
    end
  end
end
