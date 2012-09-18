class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :comment
      t.string :post_id
      t.string :user_id
      t.timestamps
    end
  end
end
