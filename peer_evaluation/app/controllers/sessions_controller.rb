class SessionsController < ApplicationController
  def new
  end

  def create
    @user=User.find_by loginID: (params[:user][:loginID])
    if (@user && @user.authenticate(params[:user][:password]))
      log_in @user
      if @user.user_type == 'instructor'
        redirect_to instructor_url :instructor => @user
      else
        redirect_to @user
      end
    else
      flash[:danger] = 'User not found.'
      redirect_to login_path
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
