class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, You logged in!"
      redirect_to home_path
    else
      flash[:error] = "Invalid email or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You're logged out."
    redirect_to login_path
  end
end