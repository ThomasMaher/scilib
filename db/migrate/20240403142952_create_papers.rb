class CreatePapers < ActiveRecord::Migration[7.1]
  def change
    create_table :papers do |t|
      t.string :title
      t.integer :year_published, precision: 4, scale: 0, index: true
      t.string :publisher, index: true
      t.text :content
      t.binary :pdf
      t.timestamps
    end
  end
end
