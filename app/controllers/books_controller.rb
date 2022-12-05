class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  def show
    @book = Book.find(params[:id])
  end
end
