class RenameColumn3 < ActiveRecord::Migration
    def self.up
      rename_column :genres, :type, :name
    end

    def self.down
      # rename back if you need or do something else or do nothing
    end

end
