class ServicesController < ApplicationController
  before_action :find_service, only: [:destroy]
  def new
    @service = Service.new task_params
  end

  def create
    @wedding = Wedding.find params[:wedding_id]
    @service = Service.new task_params
    @service.wedding = @wedding
    @service.save
    redirect_to wedding_services_path(@wedding)
  end

  def index
    @wedding = Wedding.find params[:wedding_id]
    @service = Service.new
    @services = Service.order(:vendor)
  end

  def show
  end
  def edit
  end
  def update
  end

  def destroy
    @wedding = @service.wedding
    @service.destroy
    redirect_to wedding_services_path(@wedding)
  end

  private

  def find_service
    @service = Service.find params[:id]
  end

  def task_params
    params.require(:service).permit(:vendor, :price, :budget, :chosen, tag_ids: [])
  end
end
