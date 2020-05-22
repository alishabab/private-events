class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def new
    @user = User.new
    @current_user = current_user
    # @current_user = User.find_by_id(1)
  end

  def create
    @user = User.new(signup_params)
    if @user.save
      session[:current_user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @current_user = current_user
    @past = @current_user.created_events.past
    @future = @current_user.created_events.future
  end

  private

  def signup_params
    params.require(:user).permit(:name, :email)
  end
end
