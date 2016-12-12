class WeddingsController < ApplicationController
  before_action :authenticate_user
  before_action :find_wedding, only: [:show, :destroy, :update]
  respond_to :html, :json

  def new
    @wedding = Wedding.new
  end

  def show
    @all_guests = Guest.order(:name)
    @guests = Guest.search(params[:search]) if params[:search]

    @gifts = Gift.all

    respond_to do |format|
      if params[:search].present?
        format.html { render :show }
        format.js { render :searched_guest }
      else
        format.html { render :show, alert: 'danger' }
        format.js { render js: 'alert("danger!")' }
      end
    end
  end

  def create
    wedding = Wedding.new wedding_params
    wedding.owner = current_user
    if wedding.save
      redirect_to wedding_details_path(wedding)
    else
      render :new
    end
  end

  def update
    @wedding.update_attributes(wedding_params)
    respond_to do |format|
      format.json { render json: :show_admin }
      format.html { render :show_admin }
    end
  end

  def destroy
    if @wedding.destroy
      redirect_to home_path, notice: 'Wedding Deleted.'
    else
      redirect_to home_path, alert: 'Acess Denied.'
    end
  end

  def index
    @wedding = Wedding.where(owner_id: current_user)
    @admin = User.where(wedding_id: @wedding)
  end

  def show_admin
    @wedding = Wedding.find params[:wedding_id]
    @admin = Admin.where(wedding_id: @wedding)
  end

  private

  def wedding_params
    params.require(:wedding).permit([:name,
                                     :budget,
                                     :date,
                                     :story,
                                     :owner_id,
                                     { images: [] },
                                     :role])
  end

  def find_wedding
    @wedding = Wedding.find params[:id]
  end
end
