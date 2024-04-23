class RenameNotesField < ActiveRecord::Migration[7.1]
  def self.up
    rename_column :notes, :type, :category
  end

  def self.down; end
end
