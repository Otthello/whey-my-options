class SessionsController < ApplicationController
  include SessionsHelper
  def new
    #login page need to account for reg
  end

  def create
    if request.xhr?
      set_user(login_deetz)
      puts '*'*50
      puts "user set"
      puts '*'*50
      redirect_to restaurants_path
    else
      render nothing: true, status: :bad_request
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def login_deetz
    params.require(:id)
  end
end
