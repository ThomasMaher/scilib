class Note < ApplicationRecord
  RANKS = [0, 1, 2, 3, 4, 5]
  TYPES = ['', 'highlight', 'question', 'disagreement', 'inspiration']

  belongs_to :project_paper, dependent: :destroy
  belongs_to :paper, dependent: false

  validates :project_paper_id, presence: true
  validates :rank, inclusion: RANKS
  validates :type, inclusion: TYPES
end