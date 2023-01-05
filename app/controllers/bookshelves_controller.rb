class BookshelvesController < ApplicationController

  def new
    @bookshelf = Bookshelf.new

  end

  def create
    @bookshelf = Bookshelf.new(bookshelf_params)
    @bookshelf.user = current_user
    @bookshelf.save!

    redirect_to bookshelves_path
  end

  def edit
  end

  def destroy
    @bookshelf = Bookshelf.find(params[:id])
    @bookshelf.destroy
    redirect_to bookshelves_path
  end

  def show
    @bookshelf = Bookshelf.find(params[:id])
    @bookbookshelves = BookBookshelf.where(bookshelf_id: @bookshelf.id).order(:position)
  end

  def index
    @bookshelves = Bookshelf.where(user_id: current_user.id)
  end

  private

  def bookshelf_params
    params.require(:bookshelf).permit(:name)
  end
end
