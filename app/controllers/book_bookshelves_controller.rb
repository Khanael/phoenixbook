class BookBookshelvesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create delete]

  def create
    @book_bookshelf = BookBookshelf.new(book_bookshelf_params)
    @book_bookshelf.book_id = params[:book_id]

    if @book_bookshelf.save!
      redirect_to bookshelf_path(@book_bookshelf.bookshelf)
    else
      render 'pages/home'
    end
  end

  def delete
    @book_bookshelf = BookBookshelf.find(params[:id])
    @book_bookshelf.destroy
    redirect_to bookshelves_path
  end

  private

  def book_bookshelf_params
    params.require(:book_bookshelf).permit(:bookshelf_id)
  end
end
