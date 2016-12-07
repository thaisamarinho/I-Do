class AdminsController < ApplicationController
  before_action :find_admin, only: [:destroy, :update, :show]
  respond_to :html, :json

  def new
    @admin = Admin.new
    @wedding = Wedding.find params[:wedding_id]
  end

  def create
    @wedding = Wedding.find params[:wedding_id]
    @admin = Admin.new admin_params
    @admin.wedding = @wedding
    @admin.token = SecureRandom.hex(32)
    @admin.save
    user = User.find_by(email: @admin.email)
    if user
      AdminMailer.notify_admin_user(@admin).deliver_now
    else
      AdminMailer.notify_admin(@admin).deliver_now
    end
    redirect_to wedding_path(@wedding)
  end

  def index
    @admins = Admin.where(wedding_id: params[:wedding_id])
  end

  def update
    if params[:wedding].present?
      @admin = Admin.find_by( wedding: params[:wedding],
                              token: params[:token] )
        if @admin
          @user = User.find_by(email: params[:email])
          if @user
            @admin.user = @user
            @admin.wedding = params[:wedding]
            @admin.save
            redirect_to home_path
          else
            redirect_to new_user_path
          end
        else
          redirect_to home_path, alert: 'Wrong Credentials'
        end
    end

  end

  def show
    @wedding = Wedding.find params[:wedding_id]
  end

  def destroy
    @wedding = @admin.wedding
    @admin.destroy
    redirect_to wedding_admins_path(@wedding)
  end

  private

  def find_admin
    @admin = Admin.find params[:id]
  end

  def admin_params
    params.require(:admin).permit([:email, :token])
  end
end
