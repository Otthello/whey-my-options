class SessionsController < ApplicationController
  def new
    #login page need to account for reg
  end

  def create
    user_params = login_deets
    user = User.find_by(email: user_params[:email])
    if !!user

      if user.authenticate(user_params[:password])
        session[:user_id] = user.id
        redirect_to restaurants_path
      else
        render nothing: true, status: :bad_request
      end
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def login_deets
    params.require(:user).permit(:username, :password, :email)
  end
end