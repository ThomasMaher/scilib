class CreateProjectPapers < ActiveRecord::Migration[7.1]
  def change
    create_table :project_papers do |t|
      t.integer :project_id, index: true
      t.integer :paper_id, index: true
      t.timestamps
    end
  end
end
