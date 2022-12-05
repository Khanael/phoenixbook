class AddColumnToBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :title, :string
    add_column :books, :author, :string
    add_column :books, :description, :text
    add_column :books, :publisher, :string
    add_column :books, :published_date, :date
    add_column :books, :page_count, :integer
    add_column :books, :categories, :string
    add_column :books, :image_url, :text
  end
end
