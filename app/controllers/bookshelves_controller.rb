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

    @books = Book.where( @bookshelf.id)
  end

  def index
    @bookshelves = Bookshelf.all
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:name)
  end
end
