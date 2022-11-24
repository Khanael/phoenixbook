class Bookshelf < ApplicationRecord
  has_many :book_bookshelf
  has_many :books, through: :book_bookshelf

  validates :name, presence: true
end
