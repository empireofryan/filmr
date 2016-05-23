class AddToComments < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.integer :script_id
      t.integer :user_id
    end
  end
end
