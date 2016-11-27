class GiftsController < ApplicationController
  before_action :find_gift, only:[:edit, :update, :destroy, :show]
  before_action :find_wedding, only:[:index, :create]
  respond_to :html, :json

  def index
    @gift = Gift.new
  end

  def create
    @gift = Gift.new gift_params
    @gift.wedding = @wedding
    if @gift.save
      redirect_to wedding_gifts_path(@wedding)
    else
      render :index
    end
  end

  def show
    redirect_to wedding_gifts_path(@gift.wedding)
  end

  def update
    @gift.update_attributes(gift_params)
    respond_with @gift
  end

  def destroy
    @wedding = @gift.wedding
    @gift.destroy
    redirect_to wedding_gifts_path(@wedding)
  end

  private

  def find_gift
    @gift = Gift.find params[:id]
  end

  def find_wedding
    @wedding = Wedding.find params[:wedding_id]
    @gifts = Gift.order(:item)
  end
  def gift_params
    params.require(:gift).permit([:item,
                                  :description,
                                  :quantity,
                                  { image: [] }])
  end
end
