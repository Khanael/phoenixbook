require "json"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home show search results]

  def home
    @books = Book.all.sample(10) # array of books to be displayed
    @book_bookshelf = BookBookshelf.new # instance of BookBookshelf to be used in the view

    @bookshelves = Bookshelf.all # array of bookshelves to be displayed in the view
  end

  def search
    redirect_to results_path(search_params) # redirect to the results page
  end

  def results
    @books = [] # array of books to be displayed
    @book_bookshelf = BookBookshelf.new # instance of BookBookshelf to be used in the view
    @bookshelves = Bookshelf.all # array of bookshelves to be displayed in the view
    responses = api_request(params[:search]) # array of responses from the Google Books API
    build_books(responses) # build books from the responses
  end

  def recommendations
    data = Disco.load_movielens # load data from database
    recommender = Disco::Recommender.new(factors: 20) # initialize recommender
    recommender.fit(data) # fit data to recommender
    @recommendations = recommender.item_recs("Harry Potter") # get recommendations for "Harry Potter"
    if @recommendations.empty?
      # select random books that the user don't have a vote on if no recommendations are found
      @recommendations = Book.where.not(id: current_user.votes.pluck(:book_id)).sample(10)
    end
  end

  private

  def api_request(search)
    # request to the Google Books API
    api_request = "https://www.googleapis.com/books/v1/volumes?q=#{search}&maxResults=40"

    JSON.parse(RestClient.get(api_request))["items"] # parse the response
  end

  def search_params
    params.require(:search).permit(:search) # permit the search parameter
  end

  def build_books(responses)
    # build books from the responses from the Google Books API
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
        book.average_rating = response["volumeInfo"]["averageRating"].to_f

        @books << book if book.save! # save the book if it is valid and add it to the array of books to be displayed
      else
        @books << Book.where(google_book_id: response["id"]).first
      end
    end
  end
end
