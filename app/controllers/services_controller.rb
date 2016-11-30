class ServicesController < ApplicationController
  before_action :find_service, only: [:destroy, :update]
  before_action :find_wedding, only: [:create, :index]
  respond_to :html, :json

  def create
    @service = Service.new service_params
    @service.wedding = @wedding
    @service.save
    redirect_to wedding_services_path(@wedding)
  end

  def index
    @service = Service.new
    @services = Service.order(:vendor)
  end

  def update
    @service.update_attributes(service_params)
    respond_to do |format|
      format.json { render json: {status: @service.status} }
    end

  end

  def destroy
    @service.destroy
    respond_with @service
  end

  private

  def find_service
    @service = Service.find params[:id]
  end

  def find_wedding
    @wedding = Wedding.find params[:wedding_id]
  end

  def service_params
    params.require(:service).permit(:vendor, :price, :budget, :chosen, tag_ids: [])
  end
end
