class BookBookshelvesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[create delete]

  def create
    @book_bookshelf = BookBookshelf.new(book_bookshelf_params)
    @book_bookshelf.book_id = params[:book_id]
    @bookshelf = Bookshelf.find(book_bookshelf_params[:bookshelf_id])

    if params[:position]
      @book_bookshelf.position = params[:position]
    else
      @book_bookshelf.position = @bookshelf.books.count + 1
    end

    if @book_bookshelf.save!
      redirect_to bookshelf_path(@book_bookshelf.bookshelf)
    else
      render 'pages/home'
    end
  end

  def destroy
    @book_bookshelf = BookBookshelf.find(params[:id])
    @book_bookshelf.destroy
    redirect_to bookshelves_path(@book_bookshelf.bookshelf)
  end

  private

  def book_bookshelf_params
    params.require(:book_bookshelf).permit(:bookshelf_id)
  end
end
