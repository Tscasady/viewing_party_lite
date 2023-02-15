# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    redirect_to root_path and flash[:alert] = 'You must be logged in to view your dashboard.' unless current_user 
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(permitted_params)

    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      redirect_to '/register'
      flash[:alert] = 'User was not created'
    end
  end

  def login
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def login_user
    user = User.find_by_email(params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
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
