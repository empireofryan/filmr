class CreateScripts < ActiveRecord::Migration
  def change
    create_table :scripts do |t|
      t.string :title
      t.text :logline
      t.integer :user_id
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
