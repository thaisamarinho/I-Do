class NotesController < ApplicationController
  before_action :find_note, only: [:update, :destroy]

  def create
    @service = Service.find(params[:service_id])
    @note = Note.new note_params
    @note.service = @service
    @note.user = current_user
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

  def update
    @note.update_attributes(note_params)
    redirect_to :back
  end

  def destroy
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

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def find_note
    @note = Note.find params[:id]
  end


end
