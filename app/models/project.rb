class Project < ApplicationRecord
  has_many :project_papers, dependent: :destroy
  has_many :papers, through: :project_papers

  validates :title, presence: true
end