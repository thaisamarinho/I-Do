class GuestsController < ApplicationController
  before_action :find_guest, only:[:edit, :update, :destroy, :show]
  before_action :find_wedding, only:[:index, :create]
  respond_to :html, :json

  def index
    @guest = Guest.new
    @guests = Guest.search(params[:search]).order(:first_name) if params[:search]
  end

  def create
    @guest = Guest.new guest_params
    @guest.wedding = @wedding
    if @guest.save
      redirect_to wedding_guests_path(@wedding)
    else
      render :index
    end
  end

  def show
    redirect_to wedding_guests_path(@guest.wedding)
  end

  def update
    respond_to do |format|
      if @guest.update_attributes(guest_params)
        format.html { redirect_to wedding_path(@guest.wedding)}
        format.js {render js: 'alert("Success!")'}
      else
        format.html { redirect_to :back, alert: 'Could not rsvp guest(s)' }
        format.js {render js: 'alert("Could not rsvp guest(s)")'}
      end
    end
  end

  def destroy
    @wedding = @guest.wedding
    @guest.destroy
    redirect_to wedding_guests_path(@wedding)
  end

  private

  def find_guest
    @guest = Guest.find params[:id]
  end

  def find_wedding
    @wedding = Wedding.find params[:wedding_id]
    @guests = Guest.order(:first_name)
  end

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :rsvp, :plus_one)
  end
end
