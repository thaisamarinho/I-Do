class NotesController < ApplicationController
  before_action :find_note, only: [:update, :destroy]

  def create
    @service = Service.find(params[:service_id])
    @note = Note.new note_params
    @note.service = @service
    @note.user = current_user
    save_notes
  end

  def update
    @note.update_attributes(note_params)
    redirect_to :back
  end

  def destroy
    delete_notes
  end

  private

  def note_params
    params.require(:note).permit(:body)
  end

  def find_note
    @note = Note.find params[:id]
  end
end
