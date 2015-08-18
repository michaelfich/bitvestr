class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password])
      flash[:notice] = "Thank you for logging in, #{@user.full_name} "
      redirect_to strategies_url
    else
      flash[:alert] = "Unable to log in.  Please try again."
      render :new
    end
  end

  def destroy
    logout
    flash[:notice] = "You have successfully logged out."
    redirect_to root_url
  end
end
