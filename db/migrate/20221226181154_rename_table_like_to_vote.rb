class RenameTableLikeToVote < ActiveRecord::Migration[7.0]
  def change
    rename_table :likes, :votes
  end
end
