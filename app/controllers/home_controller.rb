class HomeController < ApplicationController
  def index
      @wedding = Wedding.search(params[:search]).order(:name) if params[:search] 
  end
end
