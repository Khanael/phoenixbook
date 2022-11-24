require "json"

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home show]

  def home
    search = 'harry+potter'
    api_request = "https://www.googleapis.com/books/v1/volumes?q=#{search}&maxResults=40"

    response = RestClient.get(api_request)

    @books = JSON.parse(response)["items"]

    @bookshelves = Bookshelf.all
  end

  def show
    api_request = "https://www.googleapis.com/books/v1/volumes/#{params[:id]}"

    response = RestClient.get(api_request)

    @book = JSON.parse(response)
  end
end
