class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :user_id
      t.string :content
      t.string :category_id
      t.timestamps
    end
  end
end
