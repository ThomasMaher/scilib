class ProjectPapersController < ApplicationController
  before_action :set_project

  def new
    @project_paper = ProjectPaper.new
  end

  def create
    @paper = Paper.new(paper_params)
    @project_paper = ProjectPaper.new(project_id: @project.id)
    return failed_action(@paper) unless paper.valid?

    @project_paper.paper = paper
    return failed_action(@project_paper) unless @project_paper.valid?

    if @paper.save! && @project_paper.save!
      redirect_to project_path(@project)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def paper_params
    params.require(:paper).permit(:title, :year_published, :publisher, :content)
  end

  def set_project
    @project = Project.find(params.permit(:project_id)[:project_id])
  end

  def failed_action(record)
    render new_project_project_paper_path, message: 'Unable to create paper', errors: record.errors.full_messages
  end
end