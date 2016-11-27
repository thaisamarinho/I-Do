class WeddingsController < ApplicationController

  before_action :find_wedding, only: [:show, :destroy]

  def new
    @wedding = Wedding.new
  end

  def index
    @weddings = Wedding.order(created_at: :desc)
    @wedding = Wedding.search(params[:search]).order(:name) if params[:search]  
  end

  def show
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
