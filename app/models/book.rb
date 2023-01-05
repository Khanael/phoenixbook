class Book < ApplicationRecord
  has_many :book_bookshelf, dependent: :destroy
  has_many :bookshelves, through: :book_bookshelf
  has_many :likes
  has_many :users, through: :likes

  validates :google_book_id, presence: true, uniqueness: true


end
