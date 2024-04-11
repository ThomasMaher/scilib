class ProjectPaper < ApplicationRecord
  belongs_to :project
  belongs_to :paper, -> { by_name }

  accepts_nested_attributes_for :paper
end