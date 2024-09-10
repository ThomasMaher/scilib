class NotesController < ApplicationController
  before_action :set_note, except: [:new, :create]
  before_action :set_project_paper

  def new
    flash[:errors] = nil
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.project_paper = @project_paper || nil

    flash[:errors] = @note.errors.full_messages unless @note.valid?

    respond_to do |format|
      format.json do
        render json: {success: true} and return
        @status = @note.valid? && @note.save! ? 'Success' : 'Failed'
        render :show
      end
      format.turbo_stream do
        debugger
        render :new, status: :unprocessable_entity and return unless @note.valid? && @note.save!
      end
    end
  end

  def edit; end

  def destroy
    @note.destroy!
    respond_to do |format|
      format.html { redirect_to paper_path(@project_paper.paper_id, params: {project_id: @project_paper.project_id}) }
    end
  end


  private

  def note_params
    params.require(:note).permit(:paper_id, :quote, :note, :position, :rank, :category)
  end

  def set_note
    @note = Note.find_by(id: params.permit(:id)[:id])
  end

  def set_project_paper
    return unless params.permit(:project_paper_id).present?

    @project_paper = ProjectPaper.find_by(id: params.permit(:project_paper_id)[:project_paper_id])
  end
end