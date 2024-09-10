class PapersController < ApplicationController
  before_action :set_project

  helper_method :nested_to_project?

  def new
    flash[:errors] = []
    @paper = Paper.new
  end

  def show
    @paper = Paper.find(params.permit(:id)[:id])

    respond_to do |format|
      format.html do
          @project_paper = @paper.project_paper_by_project(@project.id) if nested_to_project?
          @notes = nested_to_project? ? @paper.project_notes(@project.id) : @paper.project_notes
      end
      format.json
    end
  end

  def index
    @papers = Paper.by_name
  end

  def create
    record = nested_to_project? ? ProjectPaper.new(project_id: @project.id, paper_attributes: paper_params) : Paper.new(paper_params)
    @paper = nested_to_project? ? record.paper : record
    unless record.valid? && record.save!
      flash[:errors] = @paper.errors.full_messages
      render :new, status: :unprocessable_entity and return
    end

    respond_to do |format|
      if nested_to_project?
        format.html { redirect_to project_path(@project) }
      else
        format.html { redirect_to papers_path(record) }
      end
    end
  end

  def destroy
    @paper = Paper.find(params.permit(:id)[:id])
    @paper.destroy!
    respond_to do |format|
      format.html { redirect_to papers_path }
      # format.turbo_stream
    end
  end


  private

  def nested_to_project?
    @project.present?
  end

  def paper_params
    params.require(:paper).permit(:title, :year_published, :publisher, :content, :pdf)
  end

  def set_project
    @project = Project.find_by(id: params.permit(:project_id)[:project_id])
  end
end