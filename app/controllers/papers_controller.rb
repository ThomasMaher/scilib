class PapersController < ApplicationController
  before_action :set_project, only: [:create, :new]

  helper_method :creating_project_paper?

  def new
    flash[:errors] = []
    @paper = Paper.new
  end

  def show
    @paper = Paper.find(params.permit(:id)[:id])
  end

  def index
    @papers = Paper.by_name
  end

  def create
    record = creating_project_paper? ? ProjectPaper.new(project_id: @project.id, paper_attributes: paper_params) : Paper.new(paper_params)
    @paper = creating_project_paper? ? record.paper : record
    unless record.valid? && record.save!
      flash[:errors] = @paper.errors.full_messages
      render :new, status: :unprocessable_entity and return
    end

    respond_to do |format|
      format.turbo_stream
      if creating_project_paper?
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
      format.turbo_stream
    end
  end


  private

  def creating_project_paper?
    @project.present?
  end

  def paper_params
    params.require(:paper).permit(:title, :year_published, :publisher, :content, :pdf)
  end

  def set_project
    @project = Project.find_by(id: params.permit(:project_id)[:project_id])
  end
end