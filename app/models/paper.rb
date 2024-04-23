class Paper < ApplicationRecord
  has_many :project_papers, dependent: :destroy
  has_many :projects, through: :project_papers
  has_many :notes, through: :project_papers

  scope :by_name, -> { order(:title) }

  validates :title, presence: true
  # validates :pdf, presence: true

  after_create_commit -> { broadcast_append_to 'papers', partial: 'papers/paper' }
  after_destroy_commit -> { broadcast_remove_to "papers" }

  def project_paper_by_project(project_id)
    ProjectPaper.find_by(paper_id: id, project_id: project_id)
  end

  def project_notes(project_id)
    project_paper_by_project(project_id)&.notes
  end
end