class TablesController < ApplicationController
  before_action :find_wedding

  def create
    @table = Table.new table_params
    @table.wedding = @wedding
    if @table.save
      redirect_to wedding_tables_path(@wedding)
    else
      render ('weddings/show_admin'), alert: 'Could not save table'
    end
  end

  def index
    @all_guests = Guest.order(:name)
    @guests = Guest.search(params[:search]).display_guest(@wedding) if params[:search]
    @table = Table.new
    @tables = Table.all
  end

  private

  def table_params
    params.require(:table).permit(:name)
  end

  def find_wedding
    @wedding = Wedding.find params[:wedding_id]
  end
end
