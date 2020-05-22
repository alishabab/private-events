class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create]

  def destroy
    session[:current_user_id] = nil
    redirect_to '/login'
  end

  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      session[:current_user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash.now[:notice] = 'User does not Exist'
      render :new
    end
  end
end
