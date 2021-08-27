class AddUniquenessToComment < ActiveRecord::Migration[6.0]
  def change
    add_index :comments, [:user_id, :tweet_id], unique: true
  end
end
