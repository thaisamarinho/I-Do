class AdminsController < ApplicationController
  before_action :find_admin, only: [:destroy, :update]
  respond_to :html, :json

  def new
    @admin = Admin.new
    @wedding = Wedding.find params[:wedding_id]
  end

  def create
    @wedding = Wedding.find params[:wedding_id]
    @admin = Admin.new admin_params
    @admin.wedding = current_user.weddings.last
    @admin.token = SecureRandom.hex(32)
    @admin.save
    AdminMailer.notify_admin(@admin).deliver_now
    redirect_to wedding_path(@wedding)
  end

  def index
    @admins = Admin.where(wedding_id: params[:wedding_id])
  end

  def update
    @admin.update_attributes(admin_params)
    respond_to do |format|
      format.json { render json: 'alert("Great!")' }
    end
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
