class ProjectsController < ApplicationController
  before_action :set_project, except: [:new, :index, :create]

  def new
    @project = Project.new
  end

  def index
    @projects = Project.all
  end

  def show; end

  def create
    project = Project.new(project_params)
    respond_to do |format|
      format.json do
        render json: {success: true} and return if project.valid? && project.save!

        render json: {error: 'Unable to create project', errors: project.errors.full_messages}
      end
      format.html do
        redirect_to project_path(project.id) and return if project.valid? && project.save!

        flash[:error] = 'Unable to create project'
        flash[:errors] = project.errors.full_messages
        redirect_to projects_path
      end
    end
  end

  def edit; end

  def update
    @project.update(project_params)
    redirect_to projects_path and return if @project.valid? && @project.save!

    flash[:error] = 'Unable to edit project'
    flash[:errors] = @project.errors.full_messages
    redirect_to projects_path, status: :unprocessable_entity
  end

  def destroy
    @project.destroy!
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.turbo_stream
    end
  end

  def unlisted_papers
    project_paper_ids = @project&.papers.map(&:id)
    @papers = Paper.by_name.reject { |paper| project_paper_ids.include?(paper.id) }
  end


  private

  def project_params
    params.require(:project).permit(:title)
  end

  def set_project
    project_id = params.permit(:id)[:id] || params.permit(:project_id)[:project_id]
    @project = Project.find_by(id: project_id)
  end
end