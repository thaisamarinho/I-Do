class HomeController < ApplicationController
  def index
    @wedding = Wedding.search(params[:search]).order(:name) if params[:search]
    @admins = Admin.where(wedding_id: @wedding)
    # byebug
  end
end
