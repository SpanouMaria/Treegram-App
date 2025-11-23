class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :photo_id
      t.integer :user_id
      t.text :text

      t.timestamps null: false
    end

    add_index :comments, :photo_id
    add_index :comments, :user_id
  end
end
