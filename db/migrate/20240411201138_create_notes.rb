class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.integer :project_paper_id, index: true
      t.integer :paper_id, index: true
      t.text :quote
      t.text :note

      t.integer :position, index: true
      t.integer :rank, index: true
      t.string :type, index: true
      t.timestamps
    end
  end
end
