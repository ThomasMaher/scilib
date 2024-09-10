class Note < ApplicationRecord
  RANKS = [0, 1, 2, 3, 4, 5]
  NO_RANK = RANKS[0]
  CATEGORIES = ['', 'highlight', 'question', 'disagreement', 'inspiration']

  belongs_to :project_paper, optional: true
  belongs_to :paper

  scope :unassigned, -> { where(project_paper_id: nil) }

  # validates :project_paper_id, presence: true
  validates :rank, inclusion: RANKS
  validates :category, inclusion: CATEGORIES

  before_validation :set_rank
  after_create_commit -> { broadcast_append_to 'notes' }
  after_destroy_commit -> { broadcast_remove_to 'notes' }

  def set_rank
    self.rank = NO_RANK if rank.blank?
  end
end