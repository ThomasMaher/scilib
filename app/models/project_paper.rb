class ProjectPaper < ApplicationRecord
  belongs_to :project
  belongs_to :paper, -> { by_name }

  has_many :notes, dependent: :destroy

  scope :by_project, ->(project_id) { where(project_id: project_id) }
  scope :by_projects, -> { order(:project_id) }

  # broadcasts_to ->(project_paper,
  #                  partial: 'projects/paper',
  #                  target: 'papers',
  #                  locals: {paper: project_paper.paper}) {[project_paper, 'papers']}
  after_create_commit -> {
    broadcast_append_to [self.project, 'project_papers'],
                        partial: 'projects/paper',
                        target: 'papers',
                        locals: {paper: self.paper}
  }
  # broadcasts_to ->(project_paper) { [project_paper.project, 'papers']}

  accepts_nested_attributes_for :paper
end