class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate( params[:session][:email],
                              params[:session][:password])
    if params[:session][:email] == "" && params[:session][:password] == ""
      flash.now[:error] = "Invalid - Email / Password field cannot not be empty"
      render 'new'
    elsif params[:session][:email] == ""
      flash.now[:error] = "Invalid - Email field cannot not be empty"
      render 'new'
    elsif params[:session][:password] == ""
      flash.now[:error] = "Invalid - Password field cannot not be empty"
      render 'new'
    elsif user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    #user credentials are correct, and we need to proceed with sign_in.
    else
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
 