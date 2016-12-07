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
    if (current_user == @gift.wedding.owner) #remmember to change this line with can manage wedding
      @gift.update_attributes(gift_params)
      respond_with @gift
    else
      respond_to do |format|
        if @gift.quantity > 0
          if @gift.update_attributes(gift_params)
            format.html { redirect_to wedding_path(@gift.wedding)}
            format.js {render js: 'alert("Your presence in our Wedding is the biggest gift you can give to us. Thank You")'}
          else
            format.html { redirect_to :back, alert: 'Could not pick this gift' }
            format.js {render js: 'alert("Could not pick this gift")'}
          end
        end
      end
    end
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
    @gifts = Gift.where(wedding: @wedding).order(:item)
  end
  def gift_params
    params.require(:gift).permit([:item,
                                  :description,
                                  :quantity,
                                  :link,
                                  { image: [] }])
  end
end
