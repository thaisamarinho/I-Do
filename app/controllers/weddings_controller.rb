class WeddingsController < ApplicationController

  before_action :find_wedding, only: [:show, :destroy]

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
    role_params = {
      owner: current_user
    }
    role_params[:bride] = current_user if params[:wedding][:role] == 'bride'
    role_params[:groom] = current_user if params[:wedding][:role] == 'groom'

    wedding = Wedding.new wedding_params.merge(role_params)

    if wedding.save
      redirect_to home_path
    else
      render :new
    end
  end

  def destroy
    if @wedding.destroy
      redirect_to home_path, notice: 'Wedding Deleted.'
    else
      redirect_to home_path, alert: 'Acess Denied.'
    end
  end

  private

  def wedding_params
    params.require(:wedding).permit([:name,
                                     :budget,
                                     :date,
                                     :bride_id,
                                     :groom_id,
                                     :owner_id,
                                     :role])
  end

  def find_wedding
    @wedding = Wedding.find params[:id]
  end

end
