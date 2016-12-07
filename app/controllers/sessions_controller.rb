class SessionsController < ApplicationController

  def new
    if params[:wedding].present?
      @wedding = params[:wedding]
      render :new_admin
    else
      render :new
    end
  end

  def create
    user = User.find_by_email params[:email].downcase
    if user && user.authenticate(params[:password])
      if params[:wedding_admin].present?
        admin = Admin.where(wedding: params[:wedding_admin]).find_by(email: user.email)
        admin.user_id = user.id
        admin.save
        session[:user_id] = user.id
        redirect_to home_path
      else
        session[:user_id] = user.id
        redirect_to home_path
      end
    else
      flash.now[:alert] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to home_path
  end

end
