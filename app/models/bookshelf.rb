class Bookshelf < ApplicationRecord
  has_many :book_bookshelf, -> { order(position: :asc) }, dependent: :destroy
  has_many :books, through: :book_bookshelf
  belongs_to :user

  validates :name, presence: true
end
