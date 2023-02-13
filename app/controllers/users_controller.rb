# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(permitted_params)

    if user.save
      redirect_to user_path(user)
    else
      redirect_to '/register'
      flash[:alert] = 'User was not created'
    end
  end

  def login
  end

  def login_user
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      redirect_to user_path(user)
    else
      redirect_to login_path
      flash[:alert] = 'Email or password invalid.'
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
