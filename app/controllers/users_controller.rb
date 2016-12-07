class UsersController < ApplicationController

  def new
    @user = User.new
    if params[:wedding].present?
      @wedding = params[:wedding]
      render :new_admin
    else
      render :new
    end
  end

  def new_admin
    @wedding = params[:wedding]
  end

  def create
    @user = User.new user_params
      if @user.save
        if params[:wedding_admin].present?
          @admin = Admin.find_by(email: @user.email)
          @admin.user = @user
          @admin.save
          session[:user_id] = @user.id
          redirect_to home_path
        else
          session[:user_id] = @user.id
          redirect_to home_path
        end
      else
        render :new
      end
  end

  private

  def user_params
    params.require(:user).permit( :first_name,
                                  :last_name,
                                  :email,
                                  :password,
                                  :password_confirmation )
  end
end
