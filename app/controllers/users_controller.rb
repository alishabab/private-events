# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
    @current_user = User.find_by_id(session[:current_user_id])
    # @current_user = User.find_by_id(1)
  end

  def create
    if @user = User.find_by(email: signup_params[:email])
      session[:current_user_id] = @user.id
      redirect_to @user
    else
    @user = User.new(signup_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to @user
    end
  end
  end

  def show
    @current_user = User.find_by_id(session[:current_user_id])
    @past = @current_user.created_events.past
    @future = @current_user.created_events.future
  end

  private

  def signup_params
    params.require(:user).permit(:name, :email)
  end
end
