class TablesController < ApplicationController
  before_action :find_wedding

  def create
    @table = Table.new table_params
    @table.wedding = @wedding
    respond_to do |format|
      if @table.save
        format.html {redirect_to wedding_tables_path(@wedding)}
        format.js { render :render_table }
      else
        render 'weddings/show_admin', alert: 'Could not save table'
      end
    end
  end

  def index
    @table = Table.new
    @tables = Table.all.includes(:guests)
    @all_guests = Guest.order(:name)
    @guests = Guest.search(params[:search]) if params[:search]
    respond_to do |format|

      if params[:search].present?
        format.html { render :index }

        format.js { render :searched_guest_table }
      else
        format.html { render :index, alert: 'danger' }
        format.json { render json: {tables: @tables.as_json(include: :guests) }}
        format.js { render js: 'alert("danger!")' }
      end

    end
  end

  private

  def table_params
    params.require(:table).permit(:name)
  end

  def find_wedding
    @wedding = Wedding.find params[:wedding_id]
  end
end
