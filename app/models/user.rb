class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes
  has_recommended :books

  def liked?(book, current_user)
    Vote.where(user_id: current_user.id, book_id: book.id, liked: true).any?
  end
end
