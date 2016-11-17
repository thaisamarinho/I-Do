class GuestsController < ApplicationController
  def index
    @guest = Guest.new
    @guests = Guest.order(:first_name)
    if params[:search]
      @guests = Guest.search(params[:search]).order(:first_name)
    end
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
    @guest = Guest.find params[:id]
    render :index
  end

  def update
    @guest = Guest.find params[:id]
    @guest.update guest_params
    redirect_to guests_path
  end

  def destroy
    @guest = Guest.find params[:id]
    @guest.destroy
    redirect_to guests_path
  end

  private

  def guest_params
    params.require(:guest).permit(:first_name, :last_name, :rsvp, :plus_one)
  end
end
