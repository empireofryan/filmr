class RenameColumn2 < ActiveRecord::Migration
  def change
    rename_column :genre, :type, :name
  end
end
