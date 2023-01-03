class AddAverageRatingToBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :average_rating, :float
  end
end
