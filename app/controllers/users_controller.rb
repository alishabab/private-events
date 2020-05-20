class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      redirect_to @user
    end

  end

  def show
  end
  private
  def signup_params
    params.require(:user).permit(:name,:email)
  end
end
