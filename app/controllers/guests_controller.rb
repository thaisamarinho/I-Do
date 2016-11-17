class GuestsController < ApplicationController
  before_action :find_guest, only:[:edit, :update, :destroy]
  def index
    @guest = Guest.new
    @guests = Guest.order(:first_name)
    @guests = Guest.search(params[:search]).order(:first_name) if params[:search]
  end

  def new
  end

  def create
    @guests = Guest.order(first_name: :asc)
    @guest = Guest.new guest_params
    if @guest.save
      redirect_to guests_path
    else
      render :index
    end
  end


  def edit
    render :index
  end

  def update
    @guest.update guest_params
    redirect_to guests_path
  end

  def destroy
    @guest.destroy
    redirect_to guests_path
  end

  private
  def find_guest
    @guest = Guest.find params[:id]
  end

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :rsvp, :plus_one)
  end
end
