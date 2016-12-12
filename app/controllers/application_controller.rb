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
        format.js { render js: 'alert("Table Saved)' }
      else
        format.html { redirect_to :back, alert: 'Could not save table' }
        format.js { render js: 'alert("Could not save table")' }
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
end
