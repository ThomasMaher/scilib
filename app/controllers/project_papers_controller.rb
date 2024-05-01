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

  def add_papers
    debugger
    papers_params.empty? ? flash[:message] = 'No papers selected.' : nil

    project_papers = papers_params.each do |paper_id|
      break if flash[:message].present?
      paper = Paper.find_by(id: paper_id)
      flash[:message] = "No paper with id: #{paper_id}" and break if paper.nil?

      project_paper = ProjectPaper.new(paper_id: paper_id, project_id: @project.id)
      unless project_paper.valid?
        flash[:message] = "Unable add papers."
        flash[:errors] = project_paper.errors.full_messages
      end
      project_paper
    end
    project_papers.each { |p| p.save! } unless flash[:message].present?

    redirect_to project_unlisted_papers_path(@project)
  end


  private

  def papers_params
    params.require(:project_paper).permit(paper_id: [])[:paper_id].reject(&:empty?)
  end

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