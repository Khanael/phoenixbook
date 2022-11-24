class Book < ApplicationRecord
  has_many :book_bookshelf
  has_many :bookshelves, through: :book_bookshelf

  validates :google_book_id, presence: true, uniqueness: true
end
