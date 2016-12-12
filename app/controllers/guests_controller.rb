class GuestsController < ApplicationController
  before_action :find_guest, only:[:edit, :update, :destroy, :show]
  before_action :find_wedding, only:[:index, :create]
  respond_to :html, :json

  def index
    @guest = Guest.new
    if (params[:confirmed])
      @guests = Guest.where(wedding: @wedding, rsvp: true)
      .search(params[:search])
      .order(:name)
    else
      @guests = Guest.where(wedding: @wedding)
      .search(params[:search])
      .order(:name) if params[:search]
    end
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
    if current_user == @guest.wedding.owner
      if params.dig(:guest,:table_id).present?
        respond_to do |format|
          if @guest.update_attributes(guest_params)
            format.html { redirect_to wedding_tables_path(@guest.wedding)}
            format.js {render js: 'alert("Table Saved)'}
          else
            format.html { redirect_to :back, alert: 'Could not save table' }
            format.js {render js: 'alert("Could not save table")'}
          end
        end
      else
        @guest.update_attributes(guest_params)
        respond_with @guest
      end
    else
      respond_to do |format|
        if @guest.update_attributes(guest_params)
          if @guest.rsvp == true
            format.html { redirect_to wedding_path(@guest.wedding)}
            format.js {render js: 'alert("😀👰🏽👱🎷🎉🎊")'}
          else
            format.html { redirect_to wedding_path(@guest.wedding)}
            format.js {render js: 'alert("😱😢")'}
          end
        else
          format.html { redirect_to :back, alert: 'Could not rsvp guest(s)' }
          format.js {render js: 'alert("Could not rsvp guest(s)")'}
        end
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
    @guests = Guest.where(wedding: @wedding).order(:name)
  end

  def guest_params
    params.require(:guest).permit(:name, :rsvp, :plus_one, :table_id)
  end
end
