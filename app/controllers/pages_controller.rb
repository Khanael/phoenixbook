require "json"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home show search results]

  def home
    @books = Book.all.sample(10)
    @book_bookshelf = BookBookshelf.new

    @bookshelves = Bookshelf.all
  end

  def search
    redirect_to results_path(search_params)
  end

  def results
    @books = []
    @book_bookshelf = BookBookshelf.new
    @bookshelves = Bookshelf.all
    responses = api_request(params[:search])
    build_books(responses)
  end

  def recommendations
    @recommendations = Book.first(5)
  end

  private

  def api_request(search)
    api_request = "https://www.googleapis.com/books/v1/volumes?q=#{search}&maxResults=40"

    JSON.parse(RestClient.get(api_request))["items"]
  end

  def search_params
    params.require(:search).permit(:search)
  end

  def build_books(responses)
    responses.each do |response|
      if Book.where(google_book_id: response["id"]).empty?
        book = Book.new
        book.google_book_id = response["id"]
        book.title = response["volumeInfo"]["title"]
        book.author = response["volumeInfo"]["authors"].join(", ") if response["volumeInfo"]["authors"]
        book.description = response["volumeInfo"]["description"]
        book.publisher = response["volumeInfo"]["publisher"]
        book.published_date = response["volumeInfo"]["publishedDate"]
        book.page_count = response["volumeInfo"]["pageCount"].to_i
        book.categories = response["volumeInfo"]["categories"].join(", ") if response["volumeInfo"]["categories"]
        book.image_url = response["volumeInfo"]["imageLinks"]["thumbnail"] if book.image_url = response["volumeInfo"]["imageLinks"]

        if book.save!
          @books << book
        end
      else
        @books << Book.where(google_book_id: response["id"]).first
      end
    end
  end
end
