class BookshelvesController < ApplicationController

  def new
    @bookshelf = Bookshelf.new

  end

  def create
    @bookshelf = Bookshelf.create(bookshelf_params)

    redirect_to bookshelves_path
  end

  def edit
  end

  def update
    @book_bookshelves = Bookshelf.find(params[:id]).book_bookshelf

    params[:positions].each do |position, index|
      @book_bookshelves.find(position['bookbookshelf_id']).update!(position: (index + 1))
    end
    render json: { message: "success" }
  end

  def destroy
  end

  def show
    @bookshelf = Bookshelf.find(params[:id])
    # order books by the position attribute in book_bookshelves
    @books = @bookshelf.book_bookshelf.order(:position).map(&:book)
  end

  def index
    @bookshelves = Bookshelf.all
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:name)
  end
end
