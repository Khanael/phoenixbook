class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @book = Book.find(params[:id])
    @bookshelves = Bookshelf.where(user: current_user)
    @book_bookshelf = BookBookshelf.new
  end
end
