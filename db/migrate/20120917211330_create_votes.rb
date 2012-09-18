class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|

      t.string :user_id
      t.string :post_flag
      t.string :pc_vote_id
      t.timestamps
    end
  end
end
