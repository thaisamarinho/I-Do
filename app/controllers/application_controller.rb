class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user
    redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
  end

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if user_signed_in?
  end
  helper_method :current_user

  def save_guests_per_table
    respond_to do |format|
      if @guest.update_attributes(guest_params)
        format.html { redirect_to wedding_tables_path(@guest.wedding) }
        format.json { render json: {result: 'ok'} }
      else
        format.html { redirect_to :back, alert: 'Could not save table' }
        format.json { render json: {error: 'could not save table'} }
      end
    end
  end
  helper_method :save_guests_per_table

  def guest_rsvp
    respond_to do |format|
      if @guest.update_attributes(guest_params)
        if @guest.rsvp == true
          format.html { redirect_to wedding_path(@guest.wedding) }
          format.js { render js: 'alert("😀👰🏽👱🎷🎉🎊")' }
        else
          format.html { redirect_to wedding_path(@guest.wedding) }
          format.js { render js: 'alert("😱😢")' }
        end
      else
        format.html { redirect_to :back, alert: 'Could not rsvp guest(s)' }
        format.js { render js: 'alert("Could not rsvp guest(s)")' }
      end
    end
  end
  helper_method :guest_rsvp

  def pick_gift
    respond_to do |format|
      if @gift.update_attributes(gift_params)
        format.html { redirect_to wedding_path(@gift.wedding) }
        format.js { render js: 'alert(
          "Your presence in our Wedding is the biggest gift you can give to us. Thank You"
          )' }
      else
        format.html { redirect_to :back,
                      alert: 'Could not pick this gift' }
        format.js { render js: 'alert("Could not pick this gift")' }
      end
    end
  end
  helper_method :pick_gift

  def save_notes
    respond_to do |format|
      if @note.save
        format.js { render :create_success }
        format.html { redirect_to :back }
      else
        format.js { render :create_failure }
        format.html { redirect_to :back, alert: 'Could not create note' }
      end
    end
  end
  helper_method :save_notes

  def delete_notes
    respond_to do |format|
      if @note.destroy
        format.html { redirect_to :back, notice: 'Note deleted!' }
        format.js { render }
      else
        format.html { redirect_to home_path, alert: 'access denied!' }
        format.js { render js: 'alert("access denied!")' }
      end
    end
  end
  helper_method :delete_notes
end
