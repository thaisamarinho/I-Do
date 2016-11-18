class ServicesController < ApplicationController
  before_action :find_service, only: [:destroy]
  def new
    @service = Service.new task_params
  end

  def create
    @service = Service.new task_params
    @service.save
    redirect_to services_path
  end

  def index
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
    @service.destroy
    redirect_to services_path
  end

  private

  def find_service
    @service = Service.find params[:id]
  end

  def task_params
    params.require(:service).permit(:vendor, :price, :budget, :chosen, tag_ids: [])
  end
end
