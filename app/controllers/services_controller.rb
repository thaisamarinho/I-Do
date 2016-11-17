class ServicesController < ApplicationController
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
    @service = Service.find params[:id]
    @service.destroy
  end

  private

  def task_params
    params.require(:service).permit(:vendor, :price, :budget, :chosen)
  end
end
