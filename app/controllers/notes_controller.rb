class NotesController < ApplicationController

  def create
    @service = Service.find(params[:service_id])
    note_params = params.require(:note).permit(:body)
    @note = Note.new note_params
    @note.service = @service
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

  def destroy
    @note = Note.find params[:id]
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

end
