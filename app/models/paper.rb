class Paper < ApplicationRecord
  has_many :project_papers, dependent: :destroy
  has_many :projects, through: :project_papers

  scope :by_name, -> { order(:title) }

  validates :title, presence: true
  # validates :pdf, presence: true
end