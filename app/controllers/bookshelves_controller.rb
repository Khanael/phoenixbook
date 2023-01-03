class BookshelvesController < ApplicationController
  skip_before_action :authenticate_user!

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
  end

  def destroy
  end

  def show
    @bookshelf = Bookshelf.find(params[:id])
    # @books = Book.where(id == @bookshelf.id)

    @books = @bookshelf.books
  end

  def index
    @bookshelves = Bookshelf.all
    render json: @bookshelves
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:name)
  end
end
