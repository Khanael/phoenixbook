class AddUserReferencesToBookshelf < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookshelves, :user, null: false, foreign_key: true
  end
end
