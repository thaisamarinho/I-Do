class WeddingsController < ApplicationController
  before_action :find_wedding, only: [:show, :destroy, :update]
  respond_to :html, :json

  def new
    @wedding = Wedding.new
  end

  def show
    @all_guests = Guest.where(rsvp: false).order(:first_name)
    @guests = Guest.search(params[:search]).where(rsvp: false).order(:first_name) if params[:search]

    respond_to do |format|
      if params[:search].present?
        format.html { render :show }
        format.js { render :searched_guest }
      else
        format.html {render :show, alert: 'danger'}
        format.js { render js: 'alert("danger!")' }
      end
    end
  end

  def create
    wedding = Wedding.new wedding_params
    wedding.owner = current_user
    if wedding.save
      redirect_to home_path
    else
      render :new
    end
  end

  def update
    @wedding.update_attributes(wedding_params)
    respond_to do |format|
      format.json { render json: 'Alert("deleted!")' }
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
  end

  private

  def wedding_params
    params.require(:wedding).permit([:name,
                                     :budget,
                                     :date,
                                     :owner_id,
                                     :role])
  end

  def find_wedding
    @wedding = Wedding.find params[:id]
  end

end
