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

  def destroy
  end

  def show
    @bookshelf = Bookshelf.find(params[:id])
    @bookbookshelves = BookBookshelf.where(bookshelf_id: @bookshelf.id).order(:position)
  end

  def index
    @bookshelves = Bookshelf.all
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:name)
  end
end
