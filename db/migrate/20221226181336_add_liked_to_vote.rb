class AddLikedToVote < ActiveRecord::Migration[7.0]
  def change
    add_column :votes, :liked, :boolean
  end
end
